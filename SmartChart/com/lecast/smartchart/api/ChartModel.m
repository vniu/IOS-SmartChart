//
//  ChartModel.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-7-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "ChartModel.h"

@implementation ChartModel

@synthesize name;
@synthesize seriesModels;
@synthesize paddingTop;
@synthesize paddingBottom;
@synthesize paddingLeft;
@synthesize paddingRight;
@synthesize verticalAxisModel;
@synthesize horizonalAxisModel;
@synthesize fontSize;
@synthesize chartLegendName;
@synthesize titleColor;
@synthesize titleName;
@synthesize radius;
@synthesize dialAxisModel;


- (id) init
{
    self = [super init];
    if (self)
    {
        seriesModels = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addSeriesModel:(SeriesModel *)seriesModel
{
    if ([seriesModels containsObject:seriesModel])
    {
        return;
    }
    [seriesModels addObject:seriesModel];
    
}
@end
