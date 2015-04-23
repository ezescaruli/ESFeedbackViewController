//
//  ESFeedbackSuggestionViewController.m
//
//  Created by Ezequiel Scaruli on 4/10/15.
//

#import "ESFeedbackSuggestionViewController.h"
#import "ESFeedbackNavigationController.h"
#import "ESFeedbackViewController.h"
#import "ESScreenUtils.h"

#import "UIColor+Hex.h"


static NSString *const ESFeedbackSuggestionTextViewFeedback = @"Write here.";


@interface ESFeedbackSuggestionViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *questionLabel;
@property (nonatomic, weak) IBOutlet UIView *separator;
@property (nonatomic, weak) IBOutlet UITextView *textView;

@end


@implementation ESFeedbackSuggestionViewController


#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupStyles];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.questionLabel.preferredMaxLayoutWidth = self.questionLabel.bounds.size.width;
    
    // A call to layoutIfNeeded is necessary in iOS 7.
    [self.view layoutIfNeeded];
}


#pragma mark - Override methods


- (NSString *)textForCancelButton {
    return @"Cancel";
}


- (NSString *)textForOKButton {
    return @"Send";
}


- (void)performCancelAction {
    [super performCancelAction];
    
    ESFeedbackNavigationController *navigationController = (ESFeedbackNavigationController *) self.navigationController;
    [navigationController finish];
}


- (void)performOKAction {
    [super performOKAction];
    
    ESFeedbackNavigationController *navigationController = (ESFeedbackNavigationController *) self.navigationController;
    [navigationController finish];
}


- (CGFloat)heightForNavigationController {
    if ([ESScreenUtils screenIsInches3_5]) {
        return 100.0;
    }
    
    return 200.0;
}


#pragma mark - Getters / Setters


- (NSString *)inputText {
    NSString *text;
    
    if (![self.textView.text isEqualToString:ESFeedbackSuggestionTextViewFeedback]) {
        text = [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    
    return text;
}


#pragma mark - UITextViewDelegate


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:ESFeedbackSuggestionTextViewFeedback]) {
        textView.text = @"";
        textView.textColor = [UIColor colorWithHex:0x595250];
    }
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = ESFeedbackSuggestionTextViewFeedback;
        textView.textColor = [UIColor lightGrayColor];
    }
}


#pragma mark - Private methods


- (void)setupStyles {
    [self setupQuestionLabel];
    [self setupSeparator];
    [self setupTextView];
}


- (void)setupQuestionLabel {
    self.questionLabel.font = [ESFeedbackViewController buttonsFont];
    self.questionLabel.textColor = [UIColor colorWithHex:0x595250];
}


- (void)setupSeparator {
    self.separator.backgroundColor = [UIColor colorWithHex:0xE0DDDC];
}


- (void)setupTextView {
    self.textView.font = [ESFeedbackViewController textFont];
    self.textView.textColor = [UIColor lightGrayColor];
    self.textView.text = ESFeedbackSuggestionTextViewFeedback;
    self.textView.delegate = self;
}


@end
