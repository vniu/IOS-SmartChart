//
//  ChartLegendCreator.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-7-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "ChartLegendCreator.h"
#import "ChartConstants.h"
#import "DiamondLegend.h"
#import "SquareLegend.h"
#import "TriangleLegend.h"
#import "CircleLegend.h"
@implementation ChartLegendCreator

+ (Legend *) getLegend : (ChartBase *) chart legendName : (NSString *)legendName
{
    Legend * legend = nil;
    if ([legendName isEqualToString:kDiamondLegend])
    {
        legend = [[DiamondLegend alloc] init];
    }
    else if ([legendName isEqualToString:kSquareLegend])
    {
        legend = [[SquareLegend alloc] init];
    }
    else if ([legendName isEqualToString:kTriangleLegend])
    {
        legend = [[TriangleLegend alloc] init];
    }
    else if ([legendName isEqualToString:kCircleLegend])
    {
        legend = [[CircleLegend alloc] init];
    }
    legend.chart = chart;
    return legend;
}

@end
