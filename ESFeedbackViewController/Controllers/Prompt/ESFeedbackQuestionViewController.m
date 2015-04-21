//
//  ESFeedbackQuestionViewController.m
//
//  Created by Ezequiel Scaruli on 4/9/15.
//

#import "ESFeedbackQuestionViewController.h"
#import "ESFeedbackViewController.h"
#import "ESFeedbackNavigationController.h"

#import "UIColor+Hex.h"


@interface ESFeedbackQuestionViewController ()

@property (nonatomic, weak) IBOutlet UILabel *textLabel;

@end


@implementation ESFeedbackQuestionViewController


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
    ESFeedbackNavigationController *navigationController = (ESFeedbackNavigationController *) self.navigationController;
    [navigationController finish];
}


- (void)performOKAction {
    [self performSegueWithIdentifier:@"PushSuggestion" sender:self];
}


#pragma mark - Private methods


- (void)setupTextLabel {
    self.textLabel.font = [ESFeedbackViewController textFont];
    self.textLabel.textColor = [UIColor colorWithHex:0x595250];
}


@end
