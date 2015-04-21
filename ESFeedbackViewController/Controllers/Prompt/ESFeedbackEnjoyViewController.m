//
//  ESFeedbackEnjoyViewController.m
//  Flock2Go
//
//  Created by Ezequiel Scaruli on 4/9/15.
//


#import "ESFeedbackEnjoyViewController.h"
#import "ESFeedbackViewController.h"

#import "UIColor+Hex.h"


@interface ESFeedbackEnjoyViewController ()

@property (nonatomic, weak) IBOutlet UILabel *textLabel;

@end


@implementation ESFeedbackEnjoyViewController


#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTextLabel];
}


#pragma mark - Override methods


- (NSString *)textForCancelButton {
    return @"Not really";
}


- (NSString *)textForOKButton {
    return @"Yes!";
}


- (void)performCancelAction {
    [self performSegueWithIdentifier:@"PushQuestion" sender:self];
}


- (void)performOKAction {
    [self performSegueWithIdentifier:@"PushRating" sender:self];
}


#pragma mark - Private methods


- (void)setupTextLabel {
    NSString *bundleName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    self.textLabel.text = [NSString stringWithFormat:@"Are you enjoying %@?", bundleName];
    self.textLabel.textColor = [UIColor colorWithHex:0x595250];
    self.textLabel.font = [ESFeedbackViewController textFont];
}


@end
