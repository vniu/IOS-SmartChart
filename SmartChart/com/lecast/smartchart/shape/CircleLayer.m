//
//  CircleLayer.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-31.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "CircleLayer.h"

@implementation CircleLayer

- (void)drawPath : (CGPoint) centerPoint radius : (CGFloat) mRadius
{
    pathRef = CGPathCreateMutable();
    CGPathAddEllipseInRect(pathRef, nil, CGRectMake(centerPoint.x - mRadius, centerPoint.y - mRadius, 2 * mRadius, 2 * mRadius));
    CGPathCloseSubpath(pathRef);
    [self setPath:pathRef];
    CFRelease(pathRef);
}

- (void)setValueHandler : (CGFloat) mValue
{
    value = mValue;
}

- (CGFloat) getValueHandler
{
    return value;
}

+ (CircleLayer *)createCircleLayer : (UIColor *)labelColor
{
    CircleLayer * circleLayer = [CircleLayer layer];
    circleLayer.lineWidth = 2;
    circleLayer.strokeColor = labelColor.CGColor;
    [circleLayer setFillColor:labelColor.CGColor];
    CATextLayer *textLayer = [self createTextLayer:labelColor];
    [CATransaction setDisableActions:YES];
    UIFont * labelFont = [UIFont systemFontOfSize:15.0];
    CGSize size = [@"0" sizeWithFont:labelFont];
    [textLayer setFrame:CGRectMake(0, 0, circleLayer.frame.size.width, size.height)];
    [CATransaction setDisableActions:NO];
    [circleLayer addSublayer:textLayer];
    return circleLayer;
}

@end
