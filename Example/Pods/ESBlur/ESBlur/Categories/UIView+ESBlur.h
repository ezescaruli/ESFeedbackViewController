//
//  UIView+ESBlur.h
//
//  Created by Ezequiel Scaruli on 4/9/15.
//

#import <UIKit/UIKit.h>

@interface UIView (ESBlur)

/**
 Convenience method. Applies a blur with a default color.
 */
- (UIView *)viewByApplyingBlur;

/**
 Returns a view that is the result of applying a blur to the receiver. It uses
 the tintColor passed as a parameter. If it is nil, it uses a default one.
 */
- (UIView *)viewByApplyingBlurWithTintColor:(UIColor *)tintColor;

@end
