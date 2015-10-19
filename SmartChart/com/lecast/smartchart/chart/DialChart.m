//
//  DialChart.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "DialChart.h"
#import "DialSeries.h"
@implementation DialChart
@synthesize dialAxis;

- (id) init : (CGContextRef) mContext dialAxis : (DialAxis *) mDialAxis
{
    self = [super init:mContext];
    if (self)
    {
        dialAxis = mDialAxis;
        radius = 130;
        dialValue = 0;
        chartLegend = nil;
        
    }
    return self;
}


- (id) init : (CGContextRef) mContext 
{
    self = [super init:mContext];
    if (self)
    {
        radius = 130;
        dialValue = 0;
        chartLegend = nil;
    }
    return self;
}

- (void)onDraw:(UIView *)view
{
    drawFinished = YES;
    [self drawLegendHandler:view];
     chartView = view;
    [self commitedCenterPoint:view];
    [self drawAxis];
    [self drawSeriesHandler:view];
}




- (void) drawSeriesHandler:(UIView *)view
{
    for (DialSeries * series in mSeries)
    {
        [self setSeriesProperty : series];
        [series setAngleRangle:dialAxis.minAngle maxAngle:dialAxis.maxAngle];
        [series setValueRangle:dialAxis.minValue maxAngle:dialAxis.maxValue];
        series.currtValue = dialValue;
        [series onDrawHandler:view];
    }
}

- (void) setDialValueHandler:(CGFloat)value
{
    dialValue = value;
    if (drawFinished)
    {
        if (mSeries.count == 0)
        {
            return;
        }
        [self setNeedsDisplay];
    }
}
- (void) drawAxis
{
    [dialAxis setCenterHandler:centerX centerY:centerY];
    dialAxis.radius = radius;
    [dialAxis drawAxisHandler : context];
}



@end
