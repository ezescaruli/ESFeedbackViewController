//
//  ESScreenUtils.m
//  ESFeedbackViewController
//
//  Created by Ezequiel Scaruli on 4/21/15.
//  Copyright (c) 2015 Ezequiel Scaruli. All rights reserved.
//

#import "ESScreenUtils.h"


static CGFloat const ESScreenUtilsDelta = 0.001;


@implementation ESScreenUtils


+ (BOOL)screenIsInches3_5 {
    return [self screenHasHeight:480.0];
}


+ (BOOL)screenIsInches4 {
    return [self screenHasHeight:568.0];
}


+ (BOOL)screenIsInches4_7 {
    return [self screenHasHeight:667.0];
}


+ (BOOL)screenIsInches5_5 {
    return [self screenHasHeight:736.0];
}


#pragma mark - Private methods


+ (BOOL)screenHasHeight:(CGFloat)height {
    UIScreen *screen = [UIScreen mainScreen];
    
    CGFloat screenHeight, heightToCompare;
    
    if ([screen respondsToSelector:@selector(nativeBounds)]) {
        // In iOS 8, the screen bounds change with the orientation. To avoid
        // that, we use native bounds that remain the same.
        screenHeight = screen.nativeBounds.size.height;
        
        // The native bounds are scaled (1x, 2x, 3x), so we have to consider the
        // native scale as well.
        heightToCompare = screen.nativeScale * height;
    } else {
        screenHeight = screen.bounds.size.height;
        heightToCompare = height;
    }
    
    return fabs(screenHeight - heightToCompare) < ESScreenUtilsDelta;
}


@end
