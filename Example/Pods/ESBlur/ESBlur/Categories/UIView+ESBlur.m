//
//  UIView+ESBlur.m
//
//  Created by Ezequiel Scaruli on 4/9/15.
//

#import "UIView+ESBlur.h"
#import "UIImageEffects.h"


static CGFloat const UIViewBlurRadius = 3.0;


@implementation UIView (ESBlur)


- (UIView *)viewByApplyingBlur {
    return [self viewByApplyingBlurWithTintColor:nil];
}


- (UIView *)viewByApplyingBlurWithTintColor:(UIColor *)tintColor {
    UIImage *image = [self takeSnapshot];
    
    UIImage *blurredImage = [UIImageEffects imageByApplyingBlurToImage:image
                                                            withRadius:UIViewBlurRadius
                                                             tintColor:tintColor ?: [self defaultBlurTintColor]
                                                 saturationDeltaFactor:1.0
                                                             maskImage:nil];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:blurredImage];
    imageView.frame = self.bounds;
    
    UIView *imageContainer = [[UIView alloc] initWithFrame:imageView.bounds];
    [imageContainer addSubview:imageView];
    
    return imageContainer;
}


#pragma mark - Private methods


- (UIImage *)takeSnapshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 1);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return snapshot;
}


- (UIColor *)defaultBlurTintColor {
    // Black color with a slight opacity.
    return [UIColor colorWithWhite:0.0 alpha:0.1];
}


@end
