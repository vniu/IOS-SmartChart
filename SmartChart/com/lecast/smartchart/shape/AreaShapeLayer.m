//
//  AreaShapeLayer.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-25.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "AreaShapeLayer.h"

@implementation AreaShapeLayer
@synthesize pathRef;
- (id) init
{
    self = [super init];
    if (self)
    {
        pathRef = CGPathCreateMutable();
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

- (void)drawPath
{
    CGPathCloseSubpath(pathRef);
    [self setPath:pathRef];
    CFRelease(pathRef);
}


@end
