//
//  AppDelegate.m
//  Example
//
//  Created by Ezequiel Scaruli on 4/24/15.
//  Copyright (c) 2015 Ezequiel Scaruli. All rights reserved.
//

#import <ESFeedbackViewController/ESFeedbackViewController.h>

#import "AppDelegate.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [ESFeedbackViewController setNumberOfLaunchesToShow:1];
    [ESFeedbackViewController registerAppLaunch];
    
    return YES;
}


@end
