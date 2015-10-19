//
//  CombinedChart.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "CombinedChart.h"
#import "CartesianSeries.h"
#import "ColumnSeries.h"
#import "AnimColumnSeries.h"
#import "AnimLineSeries.h"
@implementation CombinedChart

- (void) drawSeriesHandler:(UIView *)view
{
    NSOperationQueue * queue = [NSOperationQueue currentQueue];
    [queue setMaxConcurrentOperationCount:3];
    int count = 0;
    int lineIndexTag = 0;
    int seriesSize = [self getColumnSeriesSize];
    for (CartesianSeries *series in mSeries)
    {
        [self setSeriesProperty:series];
        if ([series isKindOfClass:[ColumnSeries class]])
        {
            series.seriesSize = seriesSize;
            series.seriesIndex = count;
            ColumnSeries * columnSeries = (ColumnSeries *) series;
            [columnSeries setQueuePriority:NSOperationQueuePriorityLow];
            count++;
        }
        if ([series isKindOfClass:[AnimLineSeries class]])
        {
            series.seriesIndex = lineIndexTag;
           // [queue addOperation:series];
            [series setQueuePriority:NSOperationQueuePriorityVeryHigh];
            lineIndexTag++;
            //continue;
        }
        if ([series isKindOfClass:[AnimColumnSeries class]])
        {
           // [queue addOperation:series];
            //continue;
        }
        //[series  start];
        [series onDrawHandler:view];
    }
}

- (int)  getColumnSeriesSize
{
    int count = 0;
    for (Series * series in mSeries)
    {
        if ([series isKindOfClass:[ColumnSeries class]])
        {
            count++;
        }
    }
    return count;
}

@end
