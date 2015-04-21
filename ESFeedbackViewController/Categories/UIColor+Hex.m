//
//  UIColor+Hex.m
//  ESFeedbackViewController
//
//  Created by Ezequiel Scaruli on 4/21/15.
//  Copyright (c) 2015 Ezequiel Scaruli. All rights reserved.
//

#import "UIColor+Hex.h"


@implementation UIColor (Hex)


+ (UIColor *)colorWithHex:(NSInteger)hex {
    CGFloat red = ((hex & 0xFF0000) >> 16) / 255.0;
    CGFloat green = ((hex & 0xFF00) >> 8) / 255.0;
    CGFloat blue = (hex & 0xFF) / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}


@end
