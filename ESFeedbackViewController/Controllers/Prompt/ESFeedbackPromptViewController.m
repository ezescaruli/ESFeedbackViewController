//
//  ESFeedbackPromptViewController.m
//
//  Created by Ezequiel Scaruli on 4/9/15.
//

#import "ESFeedbackPromptViewController.h"


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
    NSAssert(false, @"This method should be overriden in subclasses.");
}


- (void)performOKAction {
    NSAssert(false, @"This method should be overriden in subclasses.");
}


- (CGFloat)heightForNavigationController {
    CGSize size = [self.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}


@end
