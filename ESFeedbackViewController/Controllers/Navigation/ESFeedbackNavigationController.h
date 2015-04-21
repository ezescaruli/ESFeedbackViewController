//
//  ESFeedbackNavigationController.h
//
//  Created by Ezequiel Scaruli on 4/9/15.
//

#import <UIKit/UIKit.h>

#import "ESFeedbackPromptViewController.h"


@interface ESFeedbackNavigationController : UINavigationController <UINavigationControllerDelegate>

@property (nonatomic, copy) void (^onWillMoveToPromptViewController)(ESFeedbackPromptViewController *);
@property (nonatomic, copy) void (^onFinish)(void);
@property (nonatomic, copy) void (^onGoToAppStore)(void);

- (void)finish;
- (void)goToAppStore;

@end
