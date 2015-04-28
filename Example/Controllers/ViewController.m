//
//  ViewController.m
//  Example
//
//  Created by Ezequiel Scaruli on 4/24/15.
//  Copyright (c) 2015 Ezequiel Scaruli. All rights reserved.
//

#import <ESFeedbackViewController/ESFeedbackViewController.h>

#import "ViewController.h"


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ESFeedbackViewController setOnPromptWasDismissed:^(ESFeedbackPromptViewController *promptVC, BOOL ok) {
        NSLog(ok ? @"Pressed OK" : @"Pressed Cancel");
        
        if (promptVC.inputText.length > 0) {
            NSLog(@"Input text: %@", promptVC.inputText);
        }
    }];

}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [ESFeedbackViewController showIfNecessary];
}


@end
