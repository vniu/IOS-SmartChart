//
//  RadarSeries.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-20.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "RadarSeries.h"
#import "Area.h"
#import "UIColor+ChartColor.h"
#import "Circle.h"
#import "AreaShapeLayer.h"
@implementation RadarSeries

@synthesize points;
@synthesize data;
@synthesize areaSize;
@synthesize isFill;

- (id) init : (UIColor *) mColor
{
    self = [super init];
    if (self)
    {
        stroke = [[Stroke alloc] init:mColor textColor:mColor];
        isFill = NO;
    }
    return self;
}


- (void) onDrawHandler1 : (UIView*)view
{
    
    AreaShapeLayer * area = [[AreaShapeLayer alloc] init];
    area.lineWidth = 2;
    UIColor * color = [UIColor randomColor];
    area.fillColor = [[[UIColor randomColor] colorWithAlphaComponent:0.1] CGColor];
    area.strokeColor = [color CGColor];
    int count = 0;
    CGPoint startPoint;
    for (LocalPoint * value in points)
    {
        CGPoint point =  CGPointMake(value.x, value.y);
        if (count == 0)
        {
            startPoint = point;
            [area moveToPoint:startPoint];
        }
        else
        {
            [area addLineToPoint: point];
        }
        [self addClickPoint:count point:value];
        count ++;
    }
    [area addLineToPoint:startPoint];
    [view.layer addSublayer:area];
    [area drawPath];
    [self drawHighLightPoint:color];
}


- (void) onDrawHandler : (UIView*)view
{
    Area * area = [[Area alloc] init];
    if (isFill)
    {
        area.fillColor = [[UIColor randomColor] colorWithAlphaComponent:0.1];
    }
    area.strokeColor = [UIColor randomColor];
    int count = 0;
    CGPoint startPoint;
    for (LocalPoint * value in points)
    {
        CGPoint point =  CGPointMake(value.x, value.y);
        if (count == 0)
        {
            startPoint = point;
            [area moveToPoint:startPoint];
        }
        else
        {
            [area addLineToPoint: point];
        }
        [self addClickPoint:count point:value];
        count ++;
    }
    [area addLineToPoint:startPoint];
    [area drawHandler:context];
    [self drawHighLightPoint:area.strokeColor];
}

- (void) drawHighLightPoint : (UIColor *) fillColor
{
    for (LocalPoint * value in points)
    {
        Circle * circlePoint = [[Circle alloc] init:CGPointMake(value.x, value.y) radius : 4.0f];
        circlePoint.isRadialGradient = NO;
        circlePoint.fillColor = fillColor;
        [circlePoint drawHandler:context];
    }
}

- (void) addClickPoint : (int) index point : (LocalPoint *)touchPoint
{
    LocalPoint * localPoint = [[LocalPoint alloc] init];
    localPoint.x = touchPoint.x;
    localPoint.y = touchPoint.y;
    localPoint.valueField = touchPoint.valueField;
    localPoint.value = data;
    localPoint.rect = [self getClickRect:CGPointMake(touchPoint.x, touchPoint.y)];
    [pointMapping addPoint:localPoint];
}

- (CGRect) getClickRect : (CGPoint)touchPoint
{
    float scaleFactor = 15;
    int left = (int) (touchPoint.x - scaleFactor);
    int top = (int) (touchPoint.y - scaleFactor);
    return  CGRectMake(left, top, scaleFactor * 2, 2 * scaleFactor);
}

- (void) setCenterHandler : (float)mLastCenterX lastCenterY : (float)mLastCenterY  lastRadius : (float)mLastRadius
{
    centerX = mLastCenterX;
    centerY = mLastCenterY;
}

@end
