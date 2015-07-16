//
//  ESFeedbackViewController+Navigation.m
//
//  Created by Ezequiel Scaruli on 4/9/15.
//

#import "ESFeedbackViewController+Navigation.h"
#import "ESFeedbackNavigationController.h"
#import "ESFeedbackFinishViewController.h"


static CGFloat const ESFeedbackFinishPopupHeight = 44.0;


@interface ESFeedbackViewController()

@property (nonatomic, weak) UIView *navigationContainer;
@property (nonatomic, weak) UIView *generalContainer;
@property (nonatomic, strong) ESFeedbackNavigationController *feedbackNavigationController;

+ (void)clearCurrentInstance;
- (void)setupWithCurrentPromptAnimated:(BOOL)animated;
- (void)dismissClearingCurrentInstance:(BOOL)clear;
- (void)goToAppStoreAndPerformOnCompletion:(void (^)(void))completion;
- (void)promptViewController:(ESFeedbackPromptViewController *)promptVC wasDismissedChoosingOK:(BOOL)ok;

@end


@implementation ESFeedbackViewController (Navigation)


- (void)setupFeedbackNavigationController {
    self.feedbackNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"PromptNavigationController"];
    [self.feedbackNavigationController setNavigationBarHidden:YES];
    
    [self addChildViewController:self.feedbackNavigationController];
    
    self.feedbackNavigationController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.navigationContainer addSubview:self.feedbackNavigationController.view];
    
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|[navigationView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:@{@"navigationView": self.feedbackNavigationController.view}];
    [self.navigationContainer addConstraints:horizontalConstraints];
    
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[navigationView]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"navigationView": self.feedbackNavigationController.view}];
    [self.navigationContainer addConstraints:verticalConstraints];
    
    [self.feedbackNavigationController didMoveToParentViewController:self];
    
    [self setupFeedbackNavigationCallbacks];
}


- (void)setupFeedbackNavigationCallbacks {
    __weak typeof (self) safeMe = self;
    
    self.feedbackNavigationController.onWillMoveToPromptViewController = ^(ESFeedbackPromptViewController *controller) {
        [safeMe setupWithCurrentPromptAnimated:YES];
    };
    
    self.feedbackNavigationController.onPromptWasDismissed = ^(ESFeedbackPromptViewController *promptVC, BOOL ok) {
        [safeMe promptViewController:promptVC wasDismissedChoosingOK:ok];
    };
    
    self.feedbackNavigationController.onFinish = ^{
        [safeMe dismissClearingCurrentInstance:NO];
        [safeMe showFinishPopup];
    };
    
    self.feedbackNavigationController.onGoToAppStore = ^{
        [safeMe goToAppStoreAndPerformOnCompletion:^{
            [safeMe dismissClearingCurrentInstance:NO];
        }];
    };
}


- (void)showFinishPopup {
    UIViewController *hostViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    // We try to find the topmost view controller in the current showing navigation controller.
    while ([hostViewController isKindOfClass:[UINavigationController class]]) {
        hostViewController = ((UINavigationController *) hostViewController).topViewController;
    }
    
    ESFeedbackFinishViewController *finishVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Finish"];
    [self showFinishViewController:finishVC inHostViewController:hostViewController];
}


- (void)showFinishViewController:(ESFeedbackFinishViewController *)finishVC inHostViewController:(UIViewController *)hostVC {
    [hostVC addChildViewController:finishVC];
    [hostVC.view addSubview:finishVC.view];
    
    finishVC.view.frame = CGRectMake(0.0,
                                     0.0,
                                     hostVC.view.frame.size.width,
                                     ESFeedbackFinishPopupHeight);
    
    [finishVC didMoveToParentViewController:hostVC];
    
    [self fadeInFinishViewController:finishVC];
}


- (void)fadeInFinishViewController:(ESFeedbackFinishViewController *)finishVC {
    finishVC.view.alpha = 0.0;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         finishVC.view.alpha = 1.0;
                     } completion:^(BOOL completion) {
                         [self performSelector:@selector(fadeOutFinishViewController:)
                                    withObject:finishVC
                                    afterDelay:3.0];
                     }];
}


- (void)fadeOutFinishViewController:(ESFeedbackFinishViewController *)finishVC {
    [UIView animateWithDuration:1.0
                     animations:^{
                         finishVC.view.alpha = 0.0;
                     } completion:^(BOOL completion) {
                         [finishVC.view removeFromSuperview];
                         [finishVC removeFromParentViewController];
                         [ESFeedbackViewController clearCurrentInstance];
                     }];
}


@end
