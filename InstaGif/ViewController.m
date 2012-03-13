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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
	
	EditorViewController *editorViewController = [[EditorViewController alloc] init];
	
	
	NSLog(@" editorViewController: %@", editorViewController);
	[editorViewController newAnimation];
	
	//UIImagePickerController *pickerController = [[[UIImagePickerController alloc] init] autorelease];
	//EditorViewController *editorViewController = [[[EditorViewController alloc] init] autorelease];
	//[self.view addSubview:pickerController.view];
	
	//editorViewController.imagePickerController.delegate = self;
	//pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
	//pickerController.cameraOverlayView;
	
	[self presentModalViewController:editorViewController.imagePickerController animated:YES];
}

@end
