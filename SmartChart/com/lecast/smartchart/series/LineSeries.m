//
//  LineSeries.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-22.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "LineSeries.h"
#import "AxisLabel.h"
#import "Line.h"
#import "Circle.h"
@implementation LineSeries


- (id) init : (UIColor *) mColor
{
    self = [super init];
    if (self)
    {
        stroke = [[Stroke alloc] init:mColor textColor:mColor];
    }
    return self;
}

- (void) onDrawHandler : (UIView*)view
{
    [super onDrawHandler:view];
    [self drawLineHandler:view];
}

- (void) drawLineHandler : (UIView *)view
{
    int width = view.frame.size.width;
    int height = view.frame.size.height;
    int areaRectWidth = width - paddingLeft - paddingRight;
    float areaRectHeight = height - paddingBottom- paddingTop;
    float bottom = height - paddingBottom;
    NSMutableArray * axisLabels = horizontalAxis.axisLabelSetting.labels;
    int size = axisLabels.count;
    float startX = 0;
    float startY = 0;
    float stopX = 0;
    float stopY = 0;
    NSMutableArray * circlePoints = [[NSMutableArray alloc] init];
    for (int index = 0; index < size; index++)
    {
        AxisLabel * axisLabel = [axisLabels objectAtIndex:index];
        stopX = axisLabel.position * areaRectWidth + paddingLeft;
        stopY = bottom - [[propertyValues objectAtIndex:index] floatValue] * (areaRectHeight/linearAxis.maxAxisValue);
        [circlePoints addObject:[NSValue valueWithCGPoint:CGPointMake(stopX, stopY)]];
        if (index > 0)
        {
            CGPoint startPoint = CGPointMake(startX, startY);
            CGPoint endPoint =  CGPointMake(stopX, stopY);
            Line * line = [[Line alloc] initWithPoint:startPoint endPoint:endPoint strokeColor:stroke.strokeColor];
            line.lineWidth = 3;
            [line drawHandler:context];
        }
        startX = stopX;
        startY = stopY;
        [self addClickPoint:index point:CGPointMake(stopX, stopY)];
    }
    
    for (NSValue * value in circlePoints)
    {
        Circle * circlePoint = [[Circle alloc] init:value.CGPointValue radius : 4.0f];
        circlePoint.fillColor = stroke.strokeColor;
        [circlePoint drawHandler:context];
        
    }
}



@end
