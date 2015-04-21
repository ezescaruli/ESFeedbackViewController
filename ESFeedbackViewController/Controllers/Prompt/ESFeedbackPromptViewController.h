//
//  ESFeedbackPromptViewController.h
//
//  Created by Ezequiel Scaruli on 4/9/15.
//

#import <UIKit/UIKit.h>

@interface ESFeedbackPromptViewController : UIViewController

/// If the prompt has any way to input text, this property holds it.
@property (nonatomic, readonly) NSString *inputText;

- (NSString *)textForCancelButton;
- (NSString *)textForOKButton;

/** These methods are called when Cancel or OK buttons are tapped on the prompt
 view controller.
 By default, it only notifies its navigation controller that it's dismissing.
 Subclasses that override these methods should call super.
 */
- (void)performCancelAction;
- (void)performOKAction;

/**
 The height that the container navigation controller has to take when this
 view controller appears inside it.
 Defaults to the minimum compressed size of the view.
 */
- (CGFloat)heightForNavigationController;

@end
