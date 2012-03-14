//
//  EditorViewController.m
//  InstaGif
//
//  Created by Eleve on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditorViewController.h"
#import "UIImage+Resize.h"
#import "ExportViewController.h"

@implementation EditorViewController

@synthesize takeButton;
@synthesize takenImagesScroller;
@synthesize delegate;
@synthesize imagePickerController;
@synthesize timer;
@synthesize playButton;
@synthesize pauseButton;
@synthesize doneButton;
@synthesize startTime;

@class UIColor;
@class UIImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
        
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.delegate = self;
		self.imagePickerController = [[[UIImagePickerController alloc] init] autorelease];
		self.imagePickerController.delegate = self;
		
		self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
		self.imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
		self.imagePickerController.showsCameraControls = NO;
		
		// setup our custom overlay view for the camera
		//
		// ensure that our custom view's frame fits within the parent frame
		CGRect overlayViewFrame = self.imagePickerController.cameraOverlayView.frame;
		CGRect newFrame = CGRectMake(0.0,
									 0.0,
									 CGRectGetWidth(overlayViewFrame),
									 CGRectGetHeight(overlayViewFrame));
		self.view.frame = newFrame;
		[self.imagePickerController.cameraOverlayView addSubview:self.view];
    }
    
        return self;
}

- (void)dealloc {
    [self.imagePickerController release];
	[takeButton release];
	[takenImagesScroller release];
	[pictures dealloc];
	[playButton release];
	[pauseButton release];
	[animationPlayer release];
	[overlayImage release];
	[doneButton release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
	
	
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.view.opaque = NO;
	self.view.backgroundColor = [UIColor clearColor];
	
	pictures = [[NSMutableArray array] retain];
	
	overlayImage = [[[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 40.0)] autorelease];
	overlayImage.alpha = 0.3f;
	[self.view insertSubview:overlayImage belowSubview:takenImagesScroller];
}

- (void)viewDidUnload
{
	[self setTakeButton:nil];
	[self setTakenImagesScroller:nil];
	[self setPlayButton:nil];
	[self setPauseButton:nil];
	[self setDoneButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)newAnimation
{
    
}

- (IBAction)playHandler:(id)sender
{
	animationPlayer = [[[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 40.0)] autorelease];
	
	
	animationPlayer.animationImages = pictures;
	animationPlayer.animationDuration = 0.35;
	animationPlayer.animationRepeatCount = 0;
	[animationPlayer startAnimating];
	[self.view addSubview:animationPlayer];
	
	takeButton.enabled = NO;
	playButton.enabled = NO;
	pauseButton.enabled = YES;
}

- (IBAction)pauseHandler:(id)sender {
	[animationPlayer stopAnimating];
	[animationPlayer removeFromSuperview];
	
	takeButton.enabled = YES;
	playButton.enabled = YES;
	pauseButton.enabled = NO;
}

- (IBAction)doneHandler:(id)sender {
	NSString * tempFile = [NSString stringWithFormat:@"%@/%ld", NSTemporaryDirectory(), time(NULL)];
	
	ExportViewController * export = [[ExportViewController alloc] initWithImages:pictures];
	[self presentModalViewController:export animated:YES];
	[export encodeToFile:tempFile callback:^(NSString * aFile) {
		NSLog(@"encodage fini");
		/*NSData * attachmentData = [NSData dataWithContentsOfFile:aFile];
		NSLog(@"Path: %@", aFile);
		//[[NSFileManager defaultManager] removeItemAtPath:aFile error:nil];
		MFMailComposeViewController * compose = [[MFMailComposeViewController alloc] init];
		[compose setSubject:@"Gif Image"];
		[compose setMessageBody:@"I have kindly attached a GIF image to this E-mail. I made this GIF using ANGif, an open source Objective-C library for exporting animated GIFs." isHTML:NO];
		[compose addAttachmentData:attachmentData mimeType:@"image/gif" fileName:@"image.gif"];
		[compose setMailComposeDelegate:self];
		[self performSelector:@selector(showViewController:) withObject:compose afterDelay:1];
		[compose release];
		[self dismissModalViewControllerAnimated:YES];*/
	}];
	[export release];
}

- (IBAction)takePicture:(id)sender {
	[self beginTake];
}

- (IBAction)cancelEditor:(id)sender {
	// TODO : confirm
	[self.imagePickerController dismissModalViewControllerAnimated:YES];
}


- (void)beginTake
{
	if (takingPicture == NO)
	{
		takingPicture = YES;
		takeButton.enabled = NO;
		[self.imagePickerController takePicture];
	}
}

- (void)endTake
{
	takingPicture = NO;
	takeButton.enabled = YES;
}

- (void)addTakenPicture:(UIImage *) picture
{
    
    float ratio = [picture size].width / [picture size].height; 
    
    
    
    if([picture size].width >[picture size].height)
    {
        //TODO
    }
    else 
    {
        picture = [picture resizedImage:CGSizeMake(THUMBS_SIZE, THUMBS_SIZE/ratio) interpolationQuality:kCGInterpolationMedium];
        picture = [picture croppedImage:CGRectMake(0, ([picture size].height - THUMBS_SIZE)/2, THUMBS_SIZE, THUMBS_SIZE)];
    }
    
    
	UIImageView *imageView = [[UIImageView alloc] initWithImage:picture];
	[imageView setFrame:CGRectMake(THUMBS_GAP + pictures.count * (THUMBS_GAP + THUMBS_SIZE), THUMBS_GAP, THUMBS_SIZE, THUMBS_SIZE)];
	[takenImagesScroller addSubview:imageView];
	
	takenImagesScroller.contentSize = CGSizeMake(pictures.count * (THUMBS_GAP + THUMBS_SIZE) + THUMBS_GAP, 2 * THUMBS_GAP + THUMBS_SIZE);
	
	[takenImagesScroller setContentOffset:CGPointMake(takenImagesScroller.contentSize.width - takenImagesScroller.bounds.size.width, 0.0) animated:YES];
	//[self doAnimatedScrollTo:CGPointMake(takenImagesScroller.contentSize.width - takenImagesScroller.bounds.size.width, 0.0)];
	
	
	playButton.enabled = YES;
	doneButton.enabled = YES;
	
	
}


//
/*- (void) animateScroll:(NSTimer *)timerParam
 {
 const NSTimeInterval duration = 10.2;
 
 NSTimeInterval timeRunning = -[startTime timeIntervalSinceNow];
 
 if (timeRunning >= duration)
 {
 [takenImagesScroller setContentOffset:destinationOffset animated:YES];
 [timer invalidate];
 timer = nil;
 return;
 }
 CGPoint offset = [takenImagesScroller contentOffset];
 offset.y = startOffset.y + (destinationOffset.y - startOffset.y) * timeRunning / duration;
 //NSLog(@"offset: %@", offset);
 [takenImagesScroller setContentOffset:offset animated:YES];
 }
 
 - (void) doAnimatedScrollTo:(CGPoint)offset
 {
 self.startTime = [NSDate date];
 startOffset = takenImagesScroller.contentOffset;
 destinationOffset = offset;
 
 if (!timer)
 {
 self.timer =
 [NSTimer scheduledTimerWithTimeInterval:0.01
 target:self
 selector:@selector(animateScroll:)
 userInfo:nil
 repeats:YES];
 }
 }*/


#pragma mark -
#pragma mark UIImagePickerControllerDelegate


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage *pickedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	
	// pour fixer l'orientation
	UIImage *resized = [pickedImage resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(pickedImage.size.width * 0.5, pickedImage.size.height * 0.5) interpolationQuality:kCGInterpolationMedium];
	
	// compression jpeg
	NSData *jpeg = UIImageJPEGRepresentation(resized, 0.7);
	
	resized = [UIImage imageWithData:jpeg];
	
	[pictures addObject:resized];
    overlayImage.image = resized;
	
	[self addTakenPicture:resized];
	
	[self endTake];
}

/*-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
 {
 [picker dismissModalViewControllerAnimated:YES];
 }*/


// Pas util pour l'instant :
/*#pragma mark -
 #pragma mark Overlay controller delegate
 
 - (void)didTakePicture:(UIImage *)picture
 {
 //NSLog(@"didTakePicture:picture:%@", picture);
 //[self savePhoto:picture];
 }
 
 - (void)didFinishWithCamera
 {
 //[self dismissModalViewControllerAnimated:YES];
 }*/

@end
