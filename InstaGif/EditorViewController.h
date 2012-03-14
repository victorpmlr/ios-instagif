//
//  EditorViewController.h
//  InstaGif
//
//  Created by Eleve on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define THUMBS_GAP 10.0
#define THUMBS_SIZE 100.0

@protocol EditorViewControllerDelegate;

@interface EditorViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, EditorViewControllerDelegate>
{
    id <EditorViewControllerDelegate> delegate;
	UIImagePickerController *imagePickerController;
	BOOL takingPicture;
	BOOL playingAnim;
	NSMutableArray *pictures;
	UIImageView *overlayImage;
	UIImageView *animationPlayer;
	
	CGPoint startOffset;
	CGPoint destinationOffset;
	NSDate *startTime;
	NSTimer *timer;
}

@property (nonatomic, assign) id <EditorViewControllerDelegate> delegate;
@property (nonatomic, retain) UIImagePickerController *imagePickerController;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *takeButton;
@property (retain, nonatomic) IBOutlet UIScrollView *takenImagesScroller;
@property (nonatomic, retain) NSDate *startTime;
@property (nonatomic, retain) NSTimer *timer;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *playButton;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *pauseButton;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *doneButton;

- (IBAction)takePicture:(id)sender;
- (IBAction)cancelEditor:(id)sender;
- (void)beginTake;
- (void)endTake;
- (void) doAnimatedScrollTo:(CGPoint)offset;
- (void)newAnimation;
- (IBAction)playHandler:(id)sender;
- (IBAction)pauseHandler:(id)sender;
- (IBAction)doneHandler:(id)sender;

@end


@protocol EditorViewControllerDelegate
- (void)didTakePicture:(UIImage *)picture;
- (void)didFinishWithCamera;
@end