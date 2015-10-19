//
//  DialSeries.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-5.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "DialSeries.h"
#import "ImageLayer.h"
#import <QuartzCore/QuartzCore.h>
#import <GLKit/GLKit.h>
#import "UIColor+ChartColor.h"
#import "Circle.h"
#import "CircleLayer.h"
#import "DrawUtils.h"
#import "NSString+NSChartLabelDraw.h"
@implementation DialSeries
@synthesize currtValue;

- (id) init
{
    self = [super init];
    if (self)
    {
        minValue = 0;
        maxValue = 100;
        endAngle = 135;
        maxAngle = 0;
        minAngle = 0;
        angleSpacer = 0;
    }
    return self;
}

- (void) setAngleRangle : (CGFloat)mMinAngle maxAngle : (CGFloat) mMaxAngle
{
    minAngle = mMinAngle;
    maxAngle = mMaxAngle;
}

- (void) setValueRangle : (CGFloat)mMinValue maxAngle : (CGFloat) mMaxValue
{
    minValue = mMinValue;
    maxValue = mMaxValue;
}

- (void) onDrawHandler : (UIView*)view
{
    if (currtValue > maxValue)
    {
        currtValue = maxValue;
    }
    
    Circle * circle = [[Circle alloc] init:CGPointMake(centerX, centerY) radius:10];
    circle.strokeColor = [UIColor colorWithIndex : 0];
    circle.fillColor = [UIColor colorWithIndex : 1];
    circle.isRadialGradient = YES;
    [circle drawHandler:context];
    UIImage * image = [UIImage imageNamed:@"pointer.png"];
    CALayer * imageLayer = [CALayer layer];
    imageLayer.anchorPoint = CGPointMake(0 , 0.5);
    [view.layer addSublayer:imageLayer];
    imageLayer.frame =  CGRectMake(centerX, centerY - 5, radius - 10, 10);
    imageLayer.contents = (id)image.CGImage;
    NSNumber *rotationAtStart = [NSNumber numberWithFloat:GLKMathDegreesToRadians(endAngle)];
    CATransform3D transform = CATransform3DIdentity;
    [self getAngleForValue:currtValue];
    transform = CATransform3DRotate(transform, GLKMathDegreesToRadians(endAngle), 0, 0, 1.0);
    imageLayer.transform = transform;
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = 1.0;
    animation.fromValue = rotationAtStart;
    animation.toValue = [NSNumber numberWithFloat:GLKMathDegreesToRadians(endAngle)];
    [imageLayer addAnimation:animation forKey:@"transform.rotation"];
    CircleLayer * circleLayer = [CircleLayer createCircleLayer:[UIColor colorWithIndex : 2]];
    [view.layer addSublayer:circleLayer];
    [circleLayer drawPath:CGPointMake(centerX, centerY) radius:8.0f];
    suffixName = suffixName == nil ? @"" : suffixName;
    NSString * lastStr = [NSString stringWithFormat:@"%0.0f %@", currtValue, suffixName];
    CGSize  textSize = [DrawUtils getTextRect:lastStr fontSize:fontSize];
    float lastX = centerX - textSize.width/2;
    float lastY = centerY + textSize.height/2 + radius / 2;
    [lastStr drawAtPoint:CGPointMake(lastX, lastY) withFont:[UIFont systemFontOfSize:fontSize]];
    if (displayName != nil)
    {
        CGSize displayNameSize = [DrawUtils getTextRect:displayName fontSize:fontSize];
        lastX = centerX - displayNameSize.width / 2;
        lastY = centerY + displayNameSize.height/2 + radius / 2 + textSize.height;
        [displayName drawAtPoint:CGPointMake(lastX, lastY) withFont:[UIFont systemFontOfSize:fontSize]];
    }
    
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
   
}
- (void) setDataProviderHandler : (NSMutableArray *) mDataProvider
{
    return;
}

- (double) getAngleForValue : (double) value
{
    double angleDiff = maxAngle - minAngle;
    double diff = maxValue - minValue;
    rotateValue = (float) abs((value - minValue) * angleDiff / diff);
    angleSpacer = (float) rotateValue / 10;
    endAngle = minAngle + rotateValue - 180;
    return minAngle + rotateValue;
}

@end
