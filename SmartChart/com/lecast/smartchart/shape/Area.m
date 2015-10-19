//
//  Area.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-7.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Area.h"

@implementation Area

@synthesize pathRef;

- (id) init
{
    self = [super init];
    if (self)
    {
        pathRef = CGPathCreateMutable();
        lineWidth = 2;
    }
    return self;
}

- (void) moveToPoint : (CGPoint) point
{
    CGPathMoveToPoint(pathRef, nil, point.x, point.y);
}

- (void) addLineToPoint : (CGPoint) point
{
    CGPathAddLineToPoint(pathRef, nil, point.x, point.y);
}

- (void)drawHandler : (CGContextRef) context
{
    if ([super initContext:context])
    {
        CGContextAddPath(context, pathRef);
        [super fillStrokePath:context pathRef:pathRef];
        [super drawFinish:context];
    }
}

@end
