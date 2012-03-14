//
//  NavigationController.m
//  InstaGif
//
//  Created by Eleve on 14/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NavigationController.h"
#import "ViewController.h"

@implementation NavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // il faut utiliser un NSArray de viewControllers, un seul suffira
		self.viewControllers = [NSArray arrayWithObject:[[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease]];
    }
    return self;
}

@end
