//
//  ViewController.m
//  InstaGif
//
//  Created by Eleve on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "EditorViewController.h"

@implementation ViewController

@synthesize tableViewController = _tableViewController;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.tableViewController = [[[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil] autorelease];
    [self.view insertSubview:self.tableViewController.view atIndex:0];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)addActionHandler:(id)sender {
    
    UIImage *shutterImage = [UIImage imageNamed:@"shutter.png"];
    UIImageView *preload = [[[UIImageView alloc] initWithImage:shutterImage] autorelease];
    preload.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    
    
    [self.view addSubview:preload];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onClickAddGif:) userInfo:preload repeats:NO];
    }

- (void)onClickAddGif:(NSTimer *)timer{
   
    
    EditorViewController *editorViewController = [[EditorViewController alloc] init];
	//NSLog(@" editorViewController: %@", editorViewController);
	[editorViewController newAnimation];
	
	//UIImagePickerController *pickerController = [[[UIImagePickerController alloc] init] autorelease];
	//EditorViewController *editorViewController = [[[EditorViewController alloc] init] autorelease];
	//[self.view addSubview:pickerController.view];
	
	//editorViewController.imagePickerController.delegate = self;
	//pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
	//pickerController.cameraOverlayView;
	
	[self presentModalViewController:editorViewController.imagePickerController animated:NO];
    [timer.userInfo removeFromSuperview];

}

- (void)dealloc {
    [_tableViewController release];
    [super dealloc];
}
@end
