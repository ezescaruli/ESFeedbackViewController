//
//  ESFeedbackViewController+Keyboard.m
//
//  Created by Ezequiel Scaruli on 4/10/15.
//

#import "ESFeedbackViewController+Keyboard.h"


@interface ESFeedbackViewController ()

@property (nonatomic, weak) NSLayoutConstraint *generalContainerCenterContraint;

@end


@implementation ESFeedbackViewController (Keyboard)


- (void)subscribeToKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAppearWithNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


- (void)unsubscribeFromKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}


- (void)keyboardWillAppearWithNotification:(NSNotification *)notification {
    NSValue *keyboardRectValue = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [keyboardRectValue CGRectValue];
    
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        self.generalContainerCenterContraint.constant = 0.5 * keyboardRect.size.height;
        [self.view layoutIfNeeded];
    }];
}


- (void)keyboardWillHide {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        self.generalContainerCenterContraint.constant = 0.0;
        [self.view layoutIfNeeded];
    }];
}


@end
