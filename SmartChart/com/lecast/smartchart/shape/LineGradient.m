//
//  LineGradient.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-24.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "LineGradient.h"
#import "UIColor+ChartColor.h"
@implementation LineGradient

- (void) drawGradientHandler : (NSMutableArray *)gradientColors
{
    CGContextClipToRect(context, rect);
    CGGradientRef gradientRef = [self buildCGGradient:gradientColors];
    CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
    CGGradientRelease(gradientRef);
}

@end
