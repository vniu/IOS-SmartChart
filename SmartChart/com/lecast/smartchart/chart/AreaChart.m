//
//  AreaChart.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "AreaChart.h"

@implementation AreaChart


- (void) drawSeriesHandler:(UIView *)view
{
    for (CartesianSeries *series in mSeries)
    {
        [self setSeriesProperty:series];
        [series onDrawHandler:view];
    }
}

@end
