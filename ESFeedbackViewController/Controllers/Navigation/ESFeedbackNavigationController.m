//
//  ESFeedbackNavigationController.m
//
//  Created by Ezequiel Scaruli on 4/9/15.
//

#import "ESFeedbackNavigationController.h"


@implementation ESFeedbackNavigationController


#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}


#pragma mark - UINavigationControllerDelegate


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.onWillMoveToPromptViewController != nil) {
        ESFeedbackPromptViewController *promptVC = (ESFeedbackPromptViewController *) viewController;
        self.onWillMoveToPromptViewController(promptVC);
    }
}


- (void)finish {
    if (self.onFinish != nil) {
        self.onFinish();
    }
}


- (void)goToAppStore {
    if (self.onGoToAppStore != nil) {
        self.onGoToAppStore();
    }
}


@end
