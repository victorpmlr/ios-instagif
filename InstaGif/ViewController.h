//
//  ViewController.h
//  InstaGif
//
//  Created by Eleve on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TableViewController.h"
@interface ViewController : UIViewController


- (IBAction)addActionHandler:(id)sender;

@property (retain, nonatomic) TableViewController *tableViewController;

@end
