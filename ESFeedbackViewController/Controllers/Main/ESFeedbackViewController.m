//
//  ESFeedbackViewController.m
//
//  Created by Ezequiel Scaruli on 4/8/15.
//

#import <StoreKit/StoreKit.h>

#import "ESFeedbackViewController.h"
#import "ESFeedbackPromptViewController.h"
#import "ESFeedbackNavigationController.h"

#import "UIView+Blur.h"
#import "ESFeedbackViewController+Navigation.h"
#import "PCDFeedbackViewController+Keyboard.h"


static NSString *const ESFeedbackAppLaunchCountKey = @"ESFeedbackAppLaunchCount";
static NSString *const ESFeedbackWasShownKey = @"ESFeedbackWasShown";

static NSInteger PCDFeedbackNumberOfLaunchesToShow = 0;
static UIFont *PCDFeedbackTextFont;
static UIFont *PCDFeedbackButtonsFont;
static NSString *PCDFeedbackAppID;

static ESFeedbackViewController *currentInstance;


@interface ESFeedbackViewController () <SKStoreProductViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIView *navigationContainer;
@property (nonatomic, weak) IBOutlet UIView *buttonsContainer;
@property (nonatomic, weak) IBOutlet UIButton *cancelButton;
@property (nonatomic, weak) IBOutlet UIButton *OKButton;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *generalContainerHeightContraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *generalContainerCenterContraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *navigationContainerBottomContraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *buttonsContainerHeightConstraint;

@property (nonatomic, strong) UIView *blurView;
@property (nonatomic, strong) ESFeedbackNavigationController *feedbackNavigationController;

@end


@implementation ESFeedbackViewController


#pragma mark - Class methods


+ (void)registerAppLaunch {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger launchCount = [userDefaults integerForKey:ESFeedbackAppLaunchCountKey];
    ++launchCount;
    
    [userDefaults setInteger:launchCount forKey:ESFeedbackAppLaunchCountKey];
    [userDefaults synchronize];
}


+ (void)setNumberOfLaunchesToShow:(NSInteger)numberOfLaunches {
    PCDFeedbackNumberOfLaunchesToShow = numberOfLaunches;
}


+ (void)setAppID:(NSString *)appID {
    PCDFeedbackAppID = appID;
}


+ (void)showIfNecessary {
    if ([self shouldShow]) {
        ESFeedbackViewController *vc = [self instance];
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [vc showInView:window];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:YES forKey:ESFeedbackWasShownKey];
        [userDefaults synchronize];
    }
}


+ (UIFont *)textFont {
    return PCDFeedbackTextFont ?: [UIFont systemFontOfSize:13.0];
}


+ (void)setTextFont:(UIFont *)font {
    PCDFeedbackTextFont = font;
}


+ (UIFont *)buttonsFont {
    return PCDFeedbackButtonsFont ?: [UIFont boldSystemFontOfSize:15.0];
}


+ (void)setButtonsFont:(UIFont *)font {
    PCDFeedbackButtonsFont = font;
}


#pragma mark - Init / Deinit


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self != nil) {
        [self subscribeToKeyboardNotifications];
    }
    
    return self;
}


- (void)dealloc {
    [self unsubscribeFromKeyboardNotifications];
}


#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupStyles];
    [self setupFeedbackNavigationController];
    [self setupWithCurrentPromptAnimated:NO];
}


#pragma mark - Action


- (IBAction)cancelButtonAction {
    ESFeedbackPromptViewController *currentPromptVC = (ESFeedbackPromptViewController *) [self.feedbackNavigationController topViewController];
    [currentPromptVC performCancelAction];
}


- (IBAction)OKButtonAction {
    ESFeedbackPromptViewController *currentPromptVC = (ESFeedbackPromptViewController *) [self.feedbackNavigationController topViewController];
    [currentPromptVC performOKAction];
}


#pragma mark - SKStoreProductViewControllerDelegate


- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:^{
        [ESFeedbackViewController clearCurrentInstance];
    }];
}


#pragma mark - Private methods


+ (BOOL)shouldShow {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger launchCount = [userDefaults integerForKey:ESFeedbackAppLaunchCountKey];
    BOOL wasShown = [userDefaults boolForKey:ESFeedbackWasShownKey];
    
    return launchCount >= PCDFeedbackNumberOfLaunchesToShow && !wasShown;
}


+ (instancetype)instance {
    if (currentInstance == nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Feedback" bundle:nil];
        currentInstance = [storyboard instantiateInitialViewController];
    }
    
    return currentInstance;
}


+ (void)clearCurrentInstance {
    currentInstance = nil;
}


- (void)showInView:(UIView *)hostView {
    // First, a blurred view is created and added to the host view.
    self.blurView = [hostView viewByApplyingBlurWithTintColor:nil];
    [hostView addSubview:self.blurView];
    
    // Self's view is shown over the blurred view.
    [self.blurView addSubview:self.view];
    self.view.frame = self.blurView.bounds;
    
    // Show the blur view with a fade.
    self.blurView.alpha = 0.0;
    self.view.alpha = 0.0;
    [self fadeInBlurView];
}


- (void)fadeInBlurView {
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.blurView.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         [self fadeInView];
                     }];
}


- (void)fadeInView {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 1.0;
    }];
}


- (void)dismissClearingCurrentInstance:(BOOL)clear {
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.blurView.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [self.blurView removeFromSuperview];
                         
                         if (clear) {
                             [ESFeedbackViewController clearCurrentInstance];
                         }
                     }];
}


- (void)setupStyles {
    [self setupCancelButton];
    [self setupOKButton];
}


- (void)setupCancelButton {
    self.cancelButton.backgroundColor = [UIColor colorWithHex:0xFAF6F5];
    self.cancelButton.tintColor = [UIColor colorWithHex:0x595250];
    
    self.cancelButton.titleLabel.font = [ESFeedbackViewController buttonsFont];
}


- (void)setupOKButton {
    self.OKButton.backgroundColor = [UIColor colorWithHex:0x68BD4E];
    self.OKButton.tintColor = [UIColor whiteColor];
    
    self.OKButton.titleLabel.font = [ESFeedbackViewController buttonsFont];
}


- (void)setupWithCurrentPromptAnimated:(BOOL)animated {
    ESFeedbackPromptViewController *currentPromptVC = (ESFeedbackPromptViewController *) [self.feedbackNavigationController topViewController];
    
    [self.cancelButton setTitle:[currentPromptVC textForCancelButton]
                       forState:UIControlStateNormal];
    
    [self.OKButton setTitle:[currentPromptVC textForOKButton]
                   forState:UIControlStateNormal];
    
    [self setupGeneralContainerHeightAnimated:animated];
}


- (void)setupGeneralContainerHeightAnimated:(BOOL)animated {
    ESFeedbackPromptViewController *currentPromptVC = (ESFeedbackPromptViewController *) [self.feedbackNavigationController topViewController];
    
    [currentPromptVC.view setNeedsLayout];
    [currentPromptVC.view layoutIfNeeded];
    
    CGFloat heightConstant = [currentPromptVC heightForNavigationController];
    heightConstant += self.navigationContainerBottomContraint.constant;
    heightConstant += self.buttonsContainerHeightConstraint.constant;
    
    void (^animations)(void) = ^{
        self.generalContainerHeightContraint.constant = heightConstant;
        [self.view layoutIfNeeded];
    };
    
    if (animated) {
        [self.view layoutIfNeeded];
        [UIView animateWithDuration:0.5 animations:animations];
    } else {
        animations();
    }
}


- (void)goToAppStore {
    SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
    
    NSNumber *appID = @(PCDFeedbackAppID.integerValue);
    NSDictionary *parameters = @{SKStoreProductParameterITunesItemIdentifier: appID};
    
    [storeViewController loadProductWithParameters:parameters completionBlock:nil];
    storeViewController.delegate = self;
    
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    [rootVC presentViewController:storeViewController animated:YES completion:nil];
}


@end
