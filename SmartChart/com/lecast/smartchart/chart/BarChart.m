//
//  BarChart.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "BarChart.h"
#import "BarSeries.h"
@implementation BarChart

- (void) drawSeriesHandler:(UIView *)view
{
    NSOperationQueue * queue = [NSOperationQueue currentQueue];
    [queue setMaxConcurrentOperationCount:mSeries.count];
    int count = 0;
    int seriesSize = mSeries.count;
    for (BarSeries *series in mSeries)
    {
        series.seriesSize = seriesSize;
        series.seriesIndex = count;
        [self setSeriesProperty:series];
        count++;
//        if ([series isKindOfClass:[AnimColumnSeries class]])
//        {
//            [queue addOperation:series];
//            continue;
//        }
        [series onDrawHandler:view];
    }
}

@end
