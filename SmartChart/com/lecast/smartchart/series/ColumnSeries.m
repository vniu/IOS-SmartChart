//
//  ColumnSeries.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "ColumnSeries.h"
#import "AxisLabel.h"
#import "Column.h"
@implementation ColumnSeries

@synthesize barSpaceWith;


- (id) init : (UIColor *) mColor
{
    self = [super init];
    if (self)
    {
        stroke = [[Stroke alloc] init:mColor textColor:mColor];
        barSpaceWidth = 5;
    }
    return self;
}

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
    CGFloat perUnitWidth = position * areaRectWidth;
    CGFloat bottom = view.frame.size.height - paddingBottom;
    CGFloat areaRectHeight = bottom - paddingTop;
    CGFloat totalSpaceWidth = 2 * barSpaceWidth;
    CGFloat perColumnWidth = (perUnitWidth - totalSpaceWidth) / seriesSize;
    CGFloat left, top, right;
    for (int index = 0; index < size; index++)
    {
        AxisLabel * axisLabel = [axisLables objectAtIndex:index];
        stopX = axisLabel.position * areaRectWidth + paddingLeft;
        float height = [[propertyValues objectAtIndex:index] floatValue] * (areaRectHeight/linearAxis.maxAxisValue);
        stopY = bottom -  height;
        left = barSpaceWidth * (2 * index + 1) + (seriesIndex + seriesSize * index) * perColumnWidth + paddingLeft;// +
        right = left + perColumnWidth;
        top = stopY;
        Column * column = [[Column alloc] init:CGRectMake(left, top, perColumnWidth , height - 1)];
        column.fillColor = stroke.strokeColor;
        [column drawHandler:context];
        [self addClickPoint:index rect:CGRectMake(left, top, perColumnWidth, height)];
    }
}

- (void) addClickPoint : (int) index rect : (CGRect)mRect
{
    NSObject * object = [dataProvider objectAtIndex:index];
    LocalPoint * localPoint = [[LocalPoint alloc] init];
    localPoint.x = mRect.origin.x;
    localPoint.y = mRect.origin.y;
    localPoint.value = object;
    localPoint.rect = mRect;
    [pointMapping addPoint:localPoint];
}

//- (void) acceptHandler : (CartesianChart *)chart
//{
//    
//}


@end
