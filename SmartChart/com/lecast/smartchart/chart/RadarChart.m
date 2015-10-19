//
//  RadarChart.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-20.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "RadarChart.h"
#import "ReflectUtils.h"


@implementation RadarChart

@synthesize labelField;

- (id) init : (CGContextRef)mContext
{
    self = [super init : context];
    if (self)
    {
        axes = [[NSMutableArray alloc] init];
        centerRadius = 0;
        labelGap  = 5;
        pointMapping = [[PointMapping alloc] init];
        radius = 130;
    }
    return self;
}

- (void) addAxis : (RadarAxis *) axis
{
    [axes addObject:axis];
}

- (void) generateSeriesHandler
{
    [mSeries removeAllObjects];
    NSInteger itemCount = dataProvider.count;
    for (int index = 0; index < itemCount; index++)
    {
        NSObject * data = [dataProvider objectAtIndex:index];
        RadarSeries * radarSeries = [[RadarSeries alloc] init:[UIColor purpleColor]];
        [self addSeries:radarSeries];
        radarSeries.data = data;
    }
}

- (void) commitProperties
{
    [self generateSeriesHandler];
    [self updateAxisHandler];
    [self generateRadarPoints];
}

- (void) updateAxisHandler
{
    CGFloat axisAngle = M_PI * 2/[axes count];
    CGFloat angle = 0;
    for(RadarAxis *  axis in axes)
    {
        axis.context = context;
        axis.interval = 3;
        [axis setDataProviderHandler:dataProvider];
        [self setupAxisForDrawing:axis angle:angle];
       // drawAxis(axis);
        angle += axisAngle;
        [axis drawAxisLine];
        [axis drawAxisMarkHandler];
    }
}

- (void) setupAxisForDrawing : (RadarAxis *) axis angle : (CGFloat) angle
{
    axis.angle = angle;
    axis.startPoint = CGPointMake(centerX + cos(angle) * centerRadius, centerY + sin(angle) * centerRadius);
    axis.endPoint = CGPointMake(centerX + cos(angle) * (radius + labelGap), centerY + sin(angle) * (radius + labelGap));
    axis.length = radius - centerRadius - labelGap;
    axis.centerY = centerY;
    axis.centerX = centerX;
    axis.labelGap = labelGap;
    axis.radius = radius;
}


- (void)generateRadarPoints
{
    for (RadarSeries * radarSeris in mSeries)
    {
        NSMutableArray * points = [[NSMutableArray alloc] init];
        for (RadarAxis * axis in axes)
        {
            CGFloat value = [[ReflectUtils getObjectValue:radarSeris.data property:axis.valueField] floatValue];
            CGFloat sar = value * axis.length/axis.maxAxisValue + centerRadius;
            LocalPoint * point  = [[LocalPoint alloc] init];
            point.x = centerX + cos(axis.angle) * sar;
            point.y = centerY + sin(axis.angle) * sar;
            point.valueField = axis.valueField;
            [points addObject: point];
        }
        CGFloat area = 0;
        CGFloat xDiff = 0;
        CGFloat yDiff = 0;
        for(int k = 0; k < [points count] - 1; k++)
        {
            LocalPoint * prePoint = [points objectAtIndex:k];
            LocalPoint * nextPoint = [points objectAtIndex:k+1];
            xDiff = nextPoint.x - prePoint.x;
            yDiff = nextPoint.y - prePoint.y;
            area += prePoint.x * yDiff - prePoint.y * xDiff;
        }
        radarSeris.areaSize = 0.5 * area;
        radarSeris.points = points;
    }
}

- (void)onDraw:(UIView *)view
{
    chartView = view;
    if (dataProvider != nil)
    {
        [self commitedCenterPoint:view];
        [self commitProperties];
        [self drawSeriesHandler:view];
        [self drawLegendHandler:view];
    }
    drawFinished = YES;
}

- (void) drawSeriesHandler:(UIView *)view
{
    for (RadarSeries * radarSeries in mSeries)
    {
        radarSeries.pointMapping = pointMapping;
        [radarSeries setCenterHandler:centerX lastCenterY:centerY lastRadius:radius];
        [radarSeries setOffset:offsetX offsetY:offsetY];
        radarSeries.context = context;
        radarSeries.fontSize = fontSize;
        radarSeries.radius = radius;
        [radarSeries onDrawHandler:view];
    }
}

- (LocalPoint *)  getPointForScreenCoordinate: (LocalPoint *) screenPoint
{
    return [pointMapping getClickPoint:screenPoint];
}


@end
