//
//  BarSeries.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "BarSeries.h"
#import "AxisLabel.h"
#import "Column.h"
@implementation BarSeries


- (void) onDrawHandler : (UIView*)view
{
    [super onDrawHandler:view];
    [self drawColumnHandler:view];
}

- (void) drawColumnHandler : (UIView *)view
{
    CGFloat areaRectWidth = view.frame.size.width - paddingLeft - paddingRight;
    NSMutableArray * axisLables = categoryAxis.axisLabels;
    int size = axisLables.count;
    CGFloat stopX, stopY;
    AxisLabel * axisLabel = categoryAxis.baseZero ? [axisLables objectAtIndex:1]: [axisLables objectAtIndex:0];
    CGFloat position = axisLabel.position;
    CGFloat bottom = view.frame.size.height - paddingBottom;
    CGFloat areaRectHeight = bottom - paddingTop;
    CGFloat perUnitWidth = position * areaRectHeight;
    CGFloat totalSpaceWidth = 2 * barSpaceWidth;
    CGFloat perColumnWidth = (perUnitWidth - totalSpaceWidth) / seriesSize;
    CGFloat top, right, mBottom;
    paddingLeft = paddingLeft + 1;
    for (int index = 0; index < size; index++)
    {
        AxisLabel * axisLabel = [axisLables objectAtIndex:index];
        CGFloat rectWidth = [[propertyValues objectAtIndex:index] floatValue] * (areaRectWidth/linearAxis.maxAxisValue) ;
        stopX = rectWidth + paddingLeft;
        stopY = bottom - axisLabel.position * areaRectHeight;
        mBottom = bottom - ((barSpaceWidth * (2 * index + 1) + (seriesIndex + seriesSize * index)
            * perColumnWidth)); 
        top = mBottom - perColumnWidth;
        right = stopX;
        Column * column = [[Column alloc] init:CGRectMake(paddingLeft, top,  rectWidth - 1, perColumnWidth)];
        column.isVertical = NO;
        column.fillColor = stroke.strokeColor;
        [column drawHandler:context];
        [self addClickPoint:index rect:CGRectMake(paddingLeft, top, rectWidth, perColumnWidth)];
    }
}

@end
 