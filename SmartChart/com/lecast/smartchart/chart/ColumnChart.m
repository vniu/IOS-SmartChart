//
//  ColumnChart.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "ColumnChart.h"
#import "ColumnSeries.h"
#import "AnimColumnSeries.h"
@implementation ColumnChart

- (void) drawSeriesHandler:(UIView *)view
{
    NSOperationQueue * queue = [NSOperationQueue currentQueue];
    [queue cancelAllOperations];
    [queue setMaxConcurrentOperationCount:mSeries.count];
    int count = 0;
    int seriesSize = mSeries.count;
    for (ColumnSeries *series in mSeries)
    {
        series.seriesSize = seriesSize;
        series.seriesIndex = count;
        [self setSeriesProperty:series];
        count++;
        if ([series isKindOfClass:[AnimColumnSeries class]])
        {
            [queue addOperation:series];
            continue;
        }
        [series onDrawHandler:view];
    }
}

@end
