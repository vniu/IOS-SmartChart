//
//  Column.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-21.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Column.h"
#import "LineGradient.h"
#import "UIColor+ChartColor.h"
@implementation Column
@synthesize isVertical;
- (id) init : (CGRect) mRect
{
    self = [super init];
    if (self)
    {
        rect = mRect;
        pathRef = CGPathCreateMutable();
        fillColor = [UIColor redColor];
        strokeColor = [UIColor blueColor];
        lineWidth = 1;
        isVertical = true;
    }
    return self;
}

- (void)drawHandler : (CGContextRef) context
{
    if ([super initContext:context])
    {
        CGPathAddRect(pathRef, nil, rect);
        CGContextAddPath(context, pathRef);
        [super fillStrokePath:context pathRef:pathRef];
        if (fillColor)
        {
            LineGradient<IGradientDraw> * lineGradient = [[LineGradient alloc] init:context clip:rect];
            lineGradient.startPoint = CGPointMake(rect.origin.x, rect.origin.y);
            lineGradient.endPoint = isVertical ? CGPointMake(rect.origin.x + rect.size.width, rect.origin.y) : CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
            NSMutableArray * gradientColors = [[NSMutableArray alloc] init];
            [gradientColors addObject:fillColor];
            [lineGradient drawGradientHandler:gradientColors];
        }
        [super drawFinish:context];
    }
}

@end
