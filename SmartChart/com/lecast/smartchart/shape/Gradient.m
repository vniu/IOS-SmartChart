//
//  Gradient.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-5.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Gradient.h"
#import "UIColor+ChartColor.h"

@implementation Gradient
@synthesize startPoint;
@synthesize endPoint;

- (id)init : (CGContextRef)mContext clip : (CGRect) mClip
{
    self = [super init];
    if (self)
    {
        context = mContext;
        rect = mClip;
        startPoint = CGPointMake(0.5, 0);
        endPoint = CGPointMake(0.5, 1);
    }
    return self;
}

-(CGGradientRef) buildCGGradient : (NSMutableArray *) gradientColors
{
    if (gradientColors.count==1)
    {
        UIColor * color = [gradientColors objectAtIndex:0];
        [gradientColors insertObject:[color lightColor:0.2] atIndex:0];
    }
    CGFloat *colors = malloc(gradientColors.count*4*sizeof(CGFloat));
    for (int i = 0; i<gradientColors.count; i++)
    {
        CGColorRef color = [(UIColor*)[gradientColors objectAtIndex:i] CGColor];
        int numComponents = CGColorGetNumberOfComponents(color);
		const CGFloat *components = CGColorGetComponents(color);
        for (int j=0; j < numComponents; j++)
        {
            *(colors+i*4+j) = components[j];
        }
    }
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, gradientColors.count);
    free(colors);
    CGColorSpaceRelease(rgb);
    return gradient;
}

@end
