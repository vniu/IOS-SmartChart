//
//  RadialGradient.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-5.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "RadialGradient.h"

@implementation RadialGradient

@synthesize centerY;
@synthesize centerX;
@synthesize radius;


- (id)init : (CGContextRef)mContext
{
    self = [super init];
    if (self)
    {
        context = mContext;
        startPoint = CGPointMake(0.5, 0);
        endPoint = CGPointMake(0.5, 1);
    }
    return self;
}

- (void) drawGradientHandler : (NSMutableArray *)gradientColors
{
    CGGradientRef gradientRef = [self buildCGGradient:gradientColors];
    CGContextDrawRadialGradient(context, gradientRef, CGPointMake(centerX, centerY), 0, CGPointMake(centerX , centerY ), radius * 1.1, kCGGradientDrawsBeforeStartLocation);
    CGGradientRelease(gradientRef);
}

@end
