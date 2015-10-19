//
//  SeriesVO.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-27.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "SeriesModel.h"
#import "SeriesCreator.h"
#import "PieSeries.h"
@implementation SeriesModel
@synthesize valueField;
@synthesize color;
@synthesize name;
@synthesize displayName;
@synthesize strokeWidth;
@synthesize labelField;
@synthesize suffixName;

- (Series *) getSeries
{
    Series * series = [SeriesCreator getSeries:self];
    series.valueField = valueField;
    series.displayName = displayName;
    if ([series isKindOfClass:[PieSeries class]])
    {
        PieSeries *pieSeries = (PieSeries *)series;
        pieSeries.labelField = labelField;
        pieSeries.suffixName = suffixName;
    }
    return series;
}

@end
