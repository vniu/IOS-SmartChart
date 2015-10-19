//
//  SeriesCreator.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-7-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "SeriesCreator.h"
#import "ChartConstants.h"
#import "LineSeries.h"
#import "ColumnSeries.h"
#import "BarSeries.h"
#import "DialSeries.h"
#import "AreaSeries.h"
#import "PieSeries.h"

#import "UIColor+ChartColor.h"
@implementation SeriesCreator

+ (Series *) getSeries:(SeriesModel *)seriesModel
{
    if (seriesModel == NULL || seriesModel.name == nil)
    {
        return nil;
    }
    NSString * color = [seriesModel.color stringByReplacingOccurrencesOfString:@"#" withString:@""];
    color = [seriesModel.color stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    if ([seriesModel.name isEqualToString:kLineSeries])
    {
        return [[LineSeries alloc] init:[UIColor colorFromHexCode:color]];
    }
    if ([seriesModel.name isEqualToString:kAreaSeries])
    {
        return [[AreaSeries alloc] init:[UIColor colorFromHexCode:color]];
    }
    else if ([seriesModel.name isEqualToString:kColumnSeries])
    {
          return [[ColumnSeries alloc] init:[UIColor colorFromHexCode:color]];
    }
    else if ([seriesModel.name isEqualToString:kBarSeries])
    {
        return [[BarSeries alloc] init:[UIColor colorFromHexCode:color]];
    }
    else if ([seriesModel.name isEqualToString:kDialSeries])
    {
        return [[DialSeries alloc] init];
    }
    else if ([seriesModel.name isEqualToString:kPieSeries])
    {
        return [[PieSeries alloc] init];
    }
    return  nil;

}

@end
