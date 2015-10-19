//
//  GridLine.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "GridLine.h"
#import "Line.h"
@implementation GridLine
@synthesize lineStroke;
- init : (CGContextRef)mContext
{
    self = [super init];
    if (self)
    {
        context = mContext;
       // strokeColor = [UIColor colorWithRed:186.0f/255 green:206.0f/255 blue:220.0f/255 alpha:1.0f];
    }
    return self;
}

- (void) drawGridLine : (CGPoint)startPoint endPoint : (CGPoint) endPoint
{
    Line * gridLine = [[Line alloc] initWithPoint:startPoint endPoint:endPoint strokeColor:[lineStroke.strokeColor colorWithAlphaComponent:0.5]];
    gridLine.lineWidth = 1;
    [gridLine drawHandler:context];
}

- (void) drawLine : (CGPoint)startPoint endPoint : (CGPoint) endPoint lineWidth : (NSInteger)mLineWidth
{
    Line * gridLine = [[Line alloc] initWithPoint:startPoint endPoint:endPoint strokeColor:lineStroke.strokeColor];
    gridLine.lineWidth = mLineWidth;
    [gridLine drawHandler:context];
}

@end
