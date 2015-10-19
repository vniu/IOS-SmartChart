//
//  Diamon.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-17.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Diamon.h"

@implementation Diamon

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

- (void) drawDiamonHandler : (CGPoint) point
{
    CGPathMoveToPoint(pathRef, nil, point.x, point.y);
    CGFloat spacer = sqrt(pow(10, 2)/2);
    CGPathAddLineToPoint(pathRef, nil, point.x + spacer, point.y - spacer);
    CGPathAddLineToPoint(pathRef, nil, point.x + 2 * spacer, point.y);
    CGPathAddLineToPoint(pathRef, nil, point.x + spacer, point.y + spacer);
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
