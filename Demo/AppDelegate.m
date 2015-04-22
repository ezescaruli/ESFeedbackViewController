//
//  AppDelegate.m
//  ESFeedbackViewController
//
//  Created by Ezequiel Scaruli on 4/20/15.
//  Copyright (c) 2015 Ezequiel Scaruli. All rights reserved.
//

#import "AppDelegate.h"
#import "ESFeedbackViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [ESFeedbackViewController setNumberOfLaunchesToShow:1];
    [ESFeedbackViewController registerAppLaunch];
    
    [ESFeedbackViewController setOnPromptWasDismissed:^(ESFeedbackPromptViewController *promptVC, BOOL ok) {
        NSLog(ok ? @"Pressed OK" : @"Pressed Cancel");
        
        if (promptVC.inputText.length > 0) {
            NSLog(@"Input text: %@", promptVC.inputText);
        }
    }];
    
    // An example app id.
    [ESFeedbackViewController setAppID:@"838883413"];
    
    return YES;
}


@end
