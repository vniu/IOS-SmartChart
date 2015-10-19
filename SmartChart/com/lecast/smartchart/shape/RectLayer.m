//
//  RectLayer.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-21.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "RectLayer.h"

@implementation RectLayer
@synthesize left;
@synthesize rectWidth;
@synthesize height;
@synthesize bottom;


- (id)init
{
    self = [super init];
    if (self)
    {
        transform = CGAffineTransformMakeTranslation(0, 0);
    }
    return self;
}

- (void)drawPath : (CGRect) rect
{
    rectPath = CGPathCreateMutable();
    CGPathMoveToPoint(rectPath, NULL, rect.origin.x, rect.origin.y);
    CGPathAddRect(rectPath, NULL, rect);
    CGPathCloseSubpath(rectPath);
    [self setPath:rectPath];
    CFRelease(rectPath);
}

- (void) setPropertyHandler : (CGFloat)mLeft height : (CGFloat)mHeight rectWidth : (CGFloat)mRectWidth bottom : (CGFloat)mBottom
{
    left = mLeft;
    height = mHeight;
    rectWidth = mRectWidth;
    bottom = mBottom;
}
- (void)setValueHandler : (CGFloat) mValue
{
    value = mValue;
}

- (CGFloat) getValueHandler
{
    return value;
}


+ (RectLayer *)createRectLayer : (UIColor *)labelColor
{
    RectLayer * rectLayer = [[RectLayer alloc] init];
    [rectLayer setFillColor:[labelColor CGColor]];
    //[rectLayer setZPosition:0];
    [rectLayer setStrokeColor:[labelColor CGColor]];
    CATextLayer *textLayer = [self createTextLayer:labelColor];
    [CATransaction setDisableActions:YES];
    UIFont * labelFont = [UIFont systemFontOfSize:15.0];
    CGSize size = [@"0" sizeWithFont:labelFont];
    [textLayer setFrame:CGRectMake(0, 0, rectLayer.frame.size.width, size.height)];
    [CATransaction setDisableActions:NO];
    [rectLayer addSublayer:textLayer];
    return rectLayer;
}

@end
