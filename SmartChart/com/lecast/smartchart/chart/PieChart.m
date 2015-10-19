//
//  PieChart.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "PieChart.h"
#import "PieSeries.h"

@implementation PieChart

- (id) init : (CGContextRef)mContext
{
    self = [super init];
    if (self)
    {
        context = mContext;
    }
    return self;
}


- (void) drawSeriesHandler : (UIView *)view
{
    for(Series * series in mSeries)
    {
        PieSeries * pieSeries = (PieSeries *) series;
        [self setSeriesProperty:pieSeries];
        [pieSeries setDataProviderHandler:dataProvider];
        [pieSeries onDrawHandler:view];
    }
}
- (void) addSeries:(id<ISeries>)series
{
    if (mSeries.count > 0)
    {
        return;
    }
    [super addSeries:series];
}

- (void) searchIndexByTouchPoint : (LocalPoint *)point
{
    if (mSeries.count == 0 )
    {
        return;
    }
    int count = 0;
    for (NSObject * value in dataProvider)
    {
        if (value == point.value)
        {
            PieSeries * pieSeries = (PieSeries *) [mSeries objectAtIndex:0];
            [pieSeries notifySelectionChangeFrom:pieSeries.selectedSliceIndex to:count];
            return;
        }
        count++;
    }
}



@end
