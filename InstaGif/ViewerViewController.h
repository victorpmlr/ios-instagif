//
//  ViewerViewController.h
//  InstaGif
//
//  Created by Eleve on 14/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewerViewController : UIViewController
{
	NSMutableArray *pictures;
	UIImageView *animationPlayer;
}

@property (retain, nonatomic) IBOutlet UIBarButtonItem *playButton;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *pauseButton;


- (IBAction)editHandler:(id)sender;
- (IBAction)playHandler:(id)sender;
- (IBAction)pauseHandler:(id)sender;
- (IBAction)exportHandler:(id)sender;
- (IBAction)cancelHandler:(id)sender;
- (void)setImages:(NSMutableArray *)images;

@end
