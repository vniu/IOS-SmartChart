//
//  Circle.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-22.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Circle.h"
#import "RadialGradient.h"
@implementation Circle
@synthesize centerPoint;
@synthesize radius;
@synthesize isRadialGradient;

- (id) init : (CGPoint) mCenterPoint radius : (CGFloat) mRadius
{
    self = [super init];
    if (self)
    {
        centerPoint = mCenterPoint;
        radius = mRadius;
        pathRef = CGPathCreateMutable();
        fillColor = [UIColor redColor];
        strokeColor = Nil;// [UIColor blueColor];
        lineWidth = 1;
        isRadialGradient = YES;
    }
    return self;
}

- (void)drawHandler : (CGContextRef) context
{
    if ([self initContext:context])
    {
        CGPathAddEllipseInRect(pathRef, nil, CGRectMake(centerPoint.x - radius, centerPoint.y - radius, 2 * radius, 2 * radius));
        CGContextAddPath(context, pathRef);
        [self fillStrokePath:context pathRef:pathRef];
        if (isRadialGradient && fillColor)
        {
            RadialGradient<IGradientDraw> * radialGradient = [[RadialGradient alloc] init:context];
            radialGradient.centerX = centerPoint.x;
            radialGradient.centerY = centerPoint.y;
            radialGradient.radius = radius;
            NSMutableArray * gradientColors = [[NSMutableArray alloc] init];
            [gradientColors addObject:fillColor];
            [radialGradient drawGradientHandler:gradientColors];
        }
        [self drawFinish:context];
    }
}

@end
