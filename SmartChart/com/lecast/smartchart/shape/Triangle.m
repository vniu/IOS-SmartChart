//
//  Triangle.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-17.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Triangle.h"

@implementation Triangle


- (id) init
{
    self = [super init];
    if (self)
    {
        pathRef = CGPathCreateMutable();
        fillColor = [UIColor redColor];
        strokeColor = [UIColor blueColor];
        lineWidth = 1;
    }
    return self;
}

- (void) drawTriangleHandler : (CGPoint) point
{
    CGPathMoveToPoint(pathRef, nil, point.x, point.y);
    CGFloat spacer = sqrt(pow(15, 2) - pow(7.5, 2));
    CGPathAddLineToPoint(pathRef, nil, point.x + 7.5, point.y - spacer);
    CGPathAddLineToPoint(pathRef, nil, point.x + 15, point.y);
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
