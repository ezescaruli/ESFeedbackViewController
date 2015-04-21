//
//  ViewController.m
//  ESFeedbackViewController
//
//  Created by Ezequiel Scaruli on 4/20/15.
//  Copyright (c) 2015 Ezequiel Scaruli. All rights reserved.
//

#import "ViewController.h"
#import "ESFeedbackViewController.h"


@implementation ViewController


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [ESFeedbackViewController showIfNecessary];
}


@end
