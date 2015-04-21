//
//  UIView+Blur.h
//
//  Created by Ezequiel Scaruli on 4/9/15.
//

#import <UIKit/UIKit.h>

@interface UIView (Blur)

/**
 Returns a view that is the result of applying a blur to the receiver. It the
 tintColor passed as a parameter. If it is nil, it uses a default one.
 */
- (UIView *)viewByApplyingBlurWithTintColor:(UIColor *)tintColor;

@end
