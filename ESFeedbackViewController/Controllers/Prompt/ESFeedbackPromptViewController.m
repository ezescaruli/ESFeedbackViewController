//
//  ESFeedbackPromptViewController.m
//
//  Created by Ezequiel Scaruli on 4/9/15.
//

#import "ESFeedbackPromptViewController.h"
#import "ESFeedbackNavigationController.h"


@implementation ESFeedbackPromptViewController


#pragma mark - Abstract methods


- (NSString *)textForCancelButton {
    NSAssert(false, @"This method should be overriden in subclasses.");
    return nil;
}


- (NSString *)textForOKButton {
    NSAssert(false, @"This method should be overriden in subclasses.");
    return nil;
}


- (void)performCancelAction {
    ESFeedbackNavigationController *navigationController = (ESFeedbackNavigationController *) self.navigationController;
    [navigationController promptViewController:self wasDismissedChoosingOK:NO];
}


- (void)performOKAction {
    ESFeedbackNavigationController *navigationController = (ESFeedbackNavigationController *) self.navigationController;
    [navigationController promptViewController:self wasDismissedChoosingOK:YES];
}


- (CGFloat)heightForNavigationController {
    CGSize size = [self.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}


@end
