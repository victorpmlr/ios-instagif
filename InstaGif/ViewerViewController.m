//
//  ViewerViewController.m
//  InstaGif
//
//  Created by Eleve on 14/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewerViewController.h"
#import "ExportViewController.h"

@implementation ViewerViewController
@synthesize playButton;
@synthesize pauseButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setImages:(NSMutableArray *)images
{
	pictures = images;
	
	animationPlayer = [[[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 25.0)] autorelease];
	
	
	animationPlayer.animationImages = pictures;
	animationPlayer.animationDuration = pictures.count * 0.3;
	animationPlayer.animationRepeatCount = 0;
	[animationPlayer startAnimating];
	
	[self.view addSubview:animationPlayer];
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
	[self setPlayButton:nil];
	[self setPauseButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
	[playButton release];
	[pauseButton release];
    [super dealloc];
}
- (IBAction)editHandler:(id)sender {
}

- (IBAction)playHandler:(id)sender {
	[animationPlayer startAnimating];
	playButton.enabled = NO;
	pauseButton.enabled = YES;
}

- (IBAction)pauseHandler:(id)sender {
	[animationPlayer stopAnimating];
	playButton.enabled = YES;
	pauseButton.enabled = NO;
}

- (IBAction)exportHandler:(id)sender {
	
	//[imagePickerController dismissModalViewControllerAnimated:YES];
	
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

- (IBAction)cancelHandler:(id)sender {
}
@end
