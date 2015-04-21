//
//  ESFeedbackFinishViewController.m
//
//  Created by Ezequiel Scaruli on 4/10/15.
//

#import "ESFeedbackFinishViewController.h"
#import "ESFeedbackViewController.h"


@interface ESFeedbackFinishViewController ()

@property (nonatomic, strong) IBOutlet UILabel *textLabel;

@end


@implementation ESFeedbackFinishViewController


#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupStyles];
}


#pragma mark - Private methods


- (void)setupStyles {
    self.view.backgroundColor = [UIColor colorWithHex:0x68BD4E];
    [self setupTextLabel];
}


- (void)setupTextLabel {
    self.textLabel.font = [ESFeedbackViewController buttonsFont];
    self.textLabel.textColor = [UIColor whiteColor];
}


@end
