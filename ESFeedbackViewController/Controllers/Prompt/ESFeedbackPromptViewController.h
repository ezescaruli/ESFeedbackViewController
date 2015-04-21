//
//  ESFeedbackPromptViewController.h
//
//  Created by Ezequiel Scaruli on 4/9/15.
//

#import <UIKit/UIKit.h>

@interface ESFeedbackPromptViewController : UIViewController

- (NSString *)textForCancelButton;
- (NSString *)textForOKButton;

- (void)performCancelAction;
- (void)performOKAction;

/**
 The height that the container navigation controller has to take when this
 view controller appears inside it.
 Defaults to the minimum compressed size of the view.
 */
- (CGFloat)heightForNavigationController;

@end
