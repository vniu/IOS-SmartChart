//
//  Line.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-21.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Line.h"

@implementation Line

- (id)initWithPoint : (CGPoint)mStartPoint endPoint : (CGPoint)mEndPoint
{
    self = [super init];
    if (self)
    {
        startPoint = mStartPoint;
        endPoint = mEndPoint;
    }
    return self;
}
- (id)initWithPoint : (CGPoint)mStartPoint endPoint : (CGPoint)mEndPoint strokeColor : (UIColor *)mStrokeColor
{
    self = [super init];
    if (self)
    {
        startPoint = mStartPoint;
        endPoint = mEndPoint;
        strokeColor = mStrokeColor;
    }
    return self;
}

- (void)drawHandler : (CGContextRef) context
{
    if ([super initContext:context])
    {
        CGContextMoveToPoint(context, startPoint.x, startPoint.y);
        CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
        CGContextStrokePath(context);
        [super drawFinish:context];
        
    }
}
@end
