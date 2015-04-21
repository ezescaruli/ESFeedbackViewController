//
//  ESFeedbackRatingViewController.m
//
//  Created by Ezequiel Scaruli on 4/9/15.
//

#import "ESFeedbackRatingViewController.h"
#import "ESFeedbackViewController.h"
#import "ESFeedbackNavigationController.h"

#import "UIColor+Hex.h"


@interface ESFeedbackRatingViewController ()

@property (nonatomic, weak) IBOutlet UILabel *textLabel;

@end


@implementation ESFeedbackRatingViewController


#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTextLabel];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.textLabel.preferredMaxLayoutWidth = self.textLabel.bounds.size.width;
}


#pragma mark - Override methods


- (NSString *)textForCancelButton {
    return @"No, thanks";
}


- (NSString *)textForOKButton {
    return @"Okay";
}


- (void)performCancelAction {
    [super performCancelAction];
    
    ESFeedbackNavigationController *navigationController = (ESFeedbackNavigationController *) self.navigationController;
    [navigationController finish];
}


- (void)performOKAction {
    [super performOKAction];
    
    ESFeedbackNavigationController *navigationController = (ESFeedbackNavigationController *) self.navigationController;
    [navigationController goToAppStore];
}


#pragma mark - Private methods


- (void)setupTextLabel {
    self.textLabel.font = [ESFeedbackViewController textFont];
    self.textLabel.textColor = [UIColor colorWithHex:0x595250];
}


@end
