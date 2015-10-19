//
//  DialAxis.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "DialAxis.h"
#import "Line.h"
#import <GLKit/GLKit.h>
#import "DrawUtils.h"
#import "Circle.h"
#import "UIColor+ChartColor.h"
#define NULLVALUE  1.7976931348623157E308;

@implementation DialAxis
@synthesize minValue;
@synthesize maxValue;
@synthesize minAngle;
@synthesize maxAngle;
@synthesize centerX;
@synthesize centerY;
@synthesize radius;
@synthesize interval;
@synthesize mutipleSpacer;
@synthesize colors;
@synthesize stroke;
- (id) init
{
    self = [super init];
    if (self)
    {
        majorTick = NULLVALUE;
        minorTick = - NULLVALUE;
        mutipleSpacer = 2;
        interval = 10;
        minValue = 0;
        maxValue = 100;
        minAngle = 315;//315;
        maxAngle = 45;//45;
        stroke = [[Stroke alloc] init:[UIColor randomColor] fillColor:[UIColor randomColor]];
    }
    return self;
}

- (void) drawAxisHandler : (CGContextRef) mContext
{
    context = mContext;
    if (minValue == maxValue)
    {
        minValue = minValue * 0.5;
        maxValue = maxValue * 1.5;
    }
    minorTick = (maxValue - minValue) / (interval * mutipleSpacer);
    majorTick = (maxValue - minValue) / interval;
    
    Circle * circle = [[Circle alloc] init:CGPointMake(centerX, centerY) radius:radius];
    circle.strokeColor = stroke.strokeColor;
    circle.fillColor = stroke.fillColor;
    circle.isRadialGradient = YES;
    [circle drawHandler:context];
    float shortRadius = radius * .9f;
    float longRadius = radius * 1.05f;
    [self drawTicks:longRadius shortRadius:radius tick:minorTick labels:NO];
    [self drawTicks:longRadius shortRadius:shortRadius tick:majorTick labels:YES];

}

- (void) setCenterHandler : (CGFloat)mCenterX centerY : (CGFloat) mCenterY
{
    centerX = mCenterX;
    centerY = mCenterY;
}

- (void) drawTicks : (double)mLongRadius shortRadius : (double)mShortRadius tick : (double)mTick labels  :(BOOL)labels
{
    NSTextAlignment  textAlignment;
    UIFont * font = [UIFont systemFontOfSize:fontSize];
    for (double i = minValue; i <= maxValue; i += mTick)
    { 
        double angle = [self getAngleForValue:i];
        double sinValue = sin(angle);
        double cosValue = cos(angle);
        int startX = round(centerX + (float) (mShortRadius * sinValue));
        int startY = round(centerY + (float) (mShortRadius * cosValue));
        int endX = round(centerX + (float) (mLongRadius * sinValue));
        int endY = round(centerY + (float) (mLongRadius * cosValue));
        Line * gridLine = [[Line alloc] initWithPoint:CGPointMake(startX, startY) endPoint:CGPointMake(endX, endY) strokeColor:stroke.strokeColor];
        gridLine.lineWidth = 1;
        [gridLine drawHandler:context];
        if (labels)
        {
            textAlignment = NSTextAlignmentLeft;
            if (startX <= endX)
            {
                textAlignment = NSTextAlignmentRight;
            }
            NSString *textValue = [NSString stringWithFormat:@"%0.f", i];
            CGSize size = [DrawUtils getTextRect:textValue fontSize:fontSize];
            [textValue drawInRect:CGRectMake(startX, startY, size.width, size.height) withFont:font lineBreakMode:NSLineBreakByCharWrapping alignment:textAlignment];
        }
    }
}

- (double) getAngleForValue : (double)value
{
    double angleDiff = maxAngle - minAngle;
    double diff = maxValue - minValue;
    return GLKMathDegreesToRadians(minAngle + (value - minValue) * angleDiff / diff);
}



@end
