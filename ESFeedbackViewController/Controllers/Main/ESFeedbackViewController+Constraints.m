//
//  ESFeedbackViewController+Constraints.m
//  ESFeedbackViewController
//
//  Created by Ezequiel Scaruli on 4/23/15.
//  Copyright (c) 2015 Ezequiel Scaruli. All rights reserved.
//

#import "ESFeedbackViewController+Constraints.h"


@implementation ESFeedbackViewController (Constraints)


- (void)setupEdgeConstraintsForView:(UIView *)view {
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-0.0-[view]-0.0-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:@{@"view": view}];
    [view.superview addConstraints:horizontalConstraints];
    
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0.0-[view]-0.0-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:@{@"view": view}];
    [view.superview addConstraints:verticalConstraints];
}


@end
