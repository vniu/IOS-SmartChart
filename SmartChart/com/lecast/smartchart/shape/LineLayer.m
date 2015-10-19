//
//  LineLayer.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-22.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "LineLayer.h"

@implementation LineLayer
@synthesize startPoint;
@synthesize endPoint;

/*
 * 画直线路径
 *
 */

- (void)drawPath : (CGPoint) mStartPoint endPoint : (CGPoint)mEndPoint
{
    linePath = CGPathCreateMutable();
    CGPathMoveToPoint(linePath, NULL, mStartPoint.x, mStartPoint.y);
    CGPathAddLineToPoint(linePath, NULL, mEndPoint.x, mEndPoint.y);
    CGPathCloseSubpath(linePath);
    [self setPath:linePath];
    CFRelease(linePath);
}

- (void)setValueHandler : (CGFloat) mValue
{
    value = mValue;
}


- (CGFloat) getValueHandler
{
    return value;
}


+ (LineLayer *)createLineLayer : (UIColor *)labelColor
{
    LineLayer * lineLayer = [LineLayer layer];
    lineLayer.lineWidth = 2;
    lineLayer.strokeColor = labelColor.CGColor;
   // [lineLayer setFillColor:labelColor.CGColor];
    CATextLayer *textLayer = [self createTextLayer:labelColor];
    [CATransaction setDisableActions:YES];
    UIFont * labelFont = [UIFont systemFontOfSize:15.0];
    CGSize size = [@"0" sizeWithFont:labelFont];
    [textLayer setFrame:CGRectMake(0, 0, lineLayer.frame.size.width, size.height)];
    [CATransaction setDisableActions:NO];
    [lineLayer addSublayer:textLayer];
    return lineLayer;
}

@end
