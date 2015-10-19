//
//  SliceLayer.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-17.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "SliceLayer.h"
@implementation SliceLayer
@synthesize percentage;
- (NSString*)description
{
    return [NSString stringWithFormat:@"value:%f, percentage:%0.0f, start:%f, end:%f", value, percentage, startValue/M_PI*180, endValue/M_PI*180];
}


static CGPathRef CGPathCreateArc(CGPoint center, CGFloat radius, CGFloat startAngle, CGFloat endAngle)
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, center.x, center.y);
    CGPathAddArc(path, NULL, center.x, center.y, radius, startAngle, endAngle, 0);
    CGPathCloseSubpath(path);
    return path;
}

+ (SliceLayer *)createSliceLayer : (UIColor *)labelColor centerPoint : (CGPoint)pieCenter
{ 
    SliceLayer * pieLayer = [SliceLayer layer];
    [pieLayer setZPosition:0];
    //[pieLayer setStrokeColor:[[UIColor whiteColor] CGColor]];
    CATextLayer *textLayer = [self createTextLayer:labelColor];
    [CATransaction setDisableActions:YES];
    UIFont * labelFont = [UIFont systemFontOfSize:15.0];
    CGSize size = [@"0" sizeWithFont:labelFont];
    [textLayer setFrame:CGRectMake(0, 0, pieLayer.frame.size.width, size.height)];
    [CATransaction setDisableActions:NO];
    [pieLayer addSublayer:textLayer];
    return pieLayer;
}
@end
