//
//  ChartBase.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "ChartBase.h"
#import "Legend.h"
#import "SquareLegend.h"
#import "TriangleLegend.h"
#import "DiamondLegend.h"
@implementation ChartBase
@synthesize mSeries;
@synthesize dataProvider;
@synthesize scale;
@synthesize paddingLeft;
@synthesize paddingTop;
@synthesize paddingBottom;
@synthesize paddingRight;
@synthesize fontSize, offsetX, offsetY;
@synthesize pointMapping;
@synthesize context;
@synthesize chartLegend;
@synthesize chartView;
- (id) init
{
    self = [super init];
    if (self)
    {
        pointMapping = [[PointMapping alloc] init];
        mSeries = [[NSMutableArray alloc] init];
        offsetY = 0;
        offsetX = 0;
        scale = 1;
        fontSize = 15;
        chartLegend = [[SquareLegend alloc] init];
        chartLegend.chart = self;
    }
    return self;
}

- (void) setPadding : (int) mPaddingLeft paddingTop : (int)mPaddingTop paddingBottom : (int)mPaddingBottom paddingRight : (int)mPaddingRight
{
    paddingLeft = mPaddingLeft;
    paddingBottom = mPaddingBottom;
    paddingRight = mPaddingRight;
    paddingTop = mPaddingTop;
}

- (void) addSeries : (id<ISeries>)series
{
    if ([mSeries containsObject:series])
    {
        return;
    }
    [mSeries addObject:series];
}

- (void) onDraw : (UIView *)view
{
    drawFinished = YES;
    chartView = view;
    [self drawLegendHandler:view];
}



- (void) drawLegendHandler : (UIView *) view
{
    if (chartLegend != nil)
    {
        chartLegend.fontSize = fontSize;
        chartLegend.view = view;
        chartLegend.x = paddingLeft;
        chartLegend.y = view.frame.size.height - paddingBottom*3/5;
        [chartLegend executeDrawHandler:context];
    }
}

- (void) drawSeriesHandler : (UIView *)view
{
    if (dataProvider == nil)
    {
        return;
    }
}

- (LocalPoint *)  getPointForScreenCoordinate: (LocalPoint *) screenPoint
{
    return nil;
}

- (void) restore
{
    offsetX = 0;
    offsetY = 0;
    scale = 1;
}

- (void) setDataProviderHandler : (NSMutableArray *)mDataProvider
{
    dataProvider = mDataProvider;
    if (drawFinished && chartView)
    {
        [self setNeedsDisplay];
    }
}




- (void) setNeedsDisplay
{
    [chartView setNeedsDisplay];
}

@end
