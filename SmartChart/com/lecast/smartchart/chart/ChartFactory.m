//
//  ChartFactory.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-7.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "ChartFactory.h"
#import "ChartView.h"
#import "AnimBarSeries.h"
#import "AnimColumnSeries.h"
#import "AnimLineSeries.h"
#import "UIColor+ChartColor.h"
#import "DialSeries.h"
#import "DialAxis.h"
#import "AreaSeries.h"
#import "PieSeries.h"

@implementation ChartFactory

+ (ChartBase *) getChart: (NSString *) chartType context : (CGContextRef) context
{
    if ([chartType isEqualToString:@"BarChart"])
    {
        return [self getBarChart:context];
    }
    if ([chartType isEqualToString:@"LineChart"])
    {
        return [self getLineChart:context];
    }
    if ([chartType isEqualToString:@"PieChart"])
    {
       return [self getPieChart:context];
    }
    if ([chartType isEqualToString:@"DialChart"])
    {
       return [self getDialChart:context];
    }
    if([chartType isEqualToString:@"CoumlnChart"])
    {
        return [self getColumnChart:context];
    }
    if([chartType isEqualToString:@"AreaChart"])
    {
        return [self getAreaChart:context];
    }
    if([chartType isEqualToString:@"MutilColumnChart"])
    {
        return [self getMutilColumnChart:context];
    }
    if([chartType isEqualToString:@"MutilLineChart"])
    {
        return [self getMutilLineChart:context];
    }
    if([chartType isEqualToString:@"MutilLineAndColumnChart"])
    {
        return [self getLineAndColumnChart:context];
    }
    if([chartType isEqualToString:@"MutilBarChart"])
    {
        return [self getMutilBarChart:context];
    }
    if ([chartType isEqualToString:@"RadarChart"])
    {
        return [self getRadarChart : context];
    }
    return nil;
}


+ (BarChart *) getBarChart : (CGContextRef)context
{
    BarChart * barChart = [[BarChart alloc] init:context];
    [barChart setPadding:50 paddingTop:20 paddingBottom:100 paddingRight:20];
    CategoryAxis * categoryAxis = [[CategoryAxis alloc] init];
    categoryAxis.displayName = @"月份";
    categoryAxis.suffixName = @"月";
    categoryAxis.categoryField = @"categoryName";
    categoryAxis.titleAngle = 90;
    LinearAxis *linearAxis = [[LinearAxis alloc] init];
    linearAxis.displayName = @"价格";
    linearAxis.interval = 2;
    linearAxis.titleAngle = 0;
    AnimBarSeries * sseries = [[AnimBarSeries alloc]init:[UIColor colorWithIndex:6]];
    sseries.valueField = @"sname";
    AnimBarSeries * tseries = [[AnimBarSeries alloc]init:[UIColor colorWithIndex:5]];
    tseries.valueField = @"name";
    [barChart addSeries:sseries];
    sseries.displayName = @"销售量";
    barChart.verticalAxis = categoryAxis;
    barChart.horizonAxis = linearAxis;
    return barChart;
}


+ (DialChart *) getDialChart : (CGContextRef)context
{
    DialAxis * dialAxis = [[DialAxis alloc] init];
    DialChart * dialChart = [[DialChart alloc] init];
    DialSeries * dialSeries = [[DialSeries alloc] init];
    dialSeries.displayName = @"销售金额";
    dialSeries.suffixName = @"万元";
    dialChart = [[DialChart alloc] init:context dialAxis:dialAxis];
    [dialChart addSeries:dialSeries];
    return dialChart;
}


+ (AreaChart *) getAreaChart : (CGContextRef)context
{
    AreaChart *areaChart = [[AreaChart alloc] init:context];
    [areaChart setPadding:50 paddingTop:20 paddingBottom:100 paddingRight:20];
    CategoryAxis * categoryAxis = [[CategoryAxis alloc] init];
    categoryAxis.displayName = @"月份";
    categoryAxis.suffixName = @"月";
    categoryAxis.categoryField = @"categoryName";
    categoryAxis.baseZero = YES;
    LinearAxis *linearAxis = [[LinearAxis alloc] init];
    linearAxis.displayName = @"价格";
    linearAxis.interval = 10;
    AreaSeries *sseries = [[AreaSeries alloc]init:[UIColor colorWithIndex:4]];
    sseries.valueField = @"sname";
    [areaChart addSeries:sseries];
    AreaSeries *eseries = [[AreaSeries alloc]init:[UIColor colorWithIndex:5]];
    eseries.valueField = @"tname";
    
    [areaChart addSeries:eseries];
    [areaChart addSeries:sseries];
    sseries.displayName = @"销售量";
    eseries.displayName = @"A";
    //[lineChart addSeries:tseries];
    // [lineChart addSeries:sseries];
    areaChart.verticalAxis = linearAxis;
    areaChart.horizonAxis = categoryAxis;
    return areaChart;
}



+ (ColumnChart *) getColumnChart : (CGContextRef)context
{
    ColumnChart *columnChart = [[ColumnChart alloc] init:context];
    [columnChart setPadding:50 paddingTop:20 paddingBottom:100 paddingRight:20];
    CategoryAxis * categoryAxis = [[CategoryAxis alloc] init];
    categoryAxis.displayName = @"月份";
    categoryAxis.suffixName = @"月";
    categoryAxis.categoryField = @"categoryName";
    LinearAxis *linearAxis = [[LinearAxis alloc] init];
    linearAxis.displayName = @"价格";
    linearAxis.interval = 10;
    
    LineSeries *sseries = [[LineSeries alloc]init:[UIColor colorWithIndex:1]];
    sseries.valueField = @"sname";
    
    ColumnSeries *tseries = [[ColumnSeries alloc]init:[UIColor colorWithIndex:3]];
    tseries.valueField = @"tname";
    
    ColumnSeries *lseries = [[ColumnSeries alloc]init:[UIColor colorWithIndex:4]];
    lseries.valueField = @"name";
    [columnChart addSeries:lseries];
    lseries.displayName = @"销售量";
    //[lineChart addSeries:tseries];
    // [lineChart addSeries:sseries];
    columnChart.verticalAxis = linearAxis;
    columnChart.horizonAxis = categoryAxis;
    return columnChart;
}


+ (LineChart *) getLineChart : (CGContextRef)context
{
    LineChart *lineChart = [[LineChart alloc] init:context];
    [lineChart setPadding:50 paddingTop:20 paddingBottom:100 paddingRight:20];
    CategoryAxis * categoryAxis = [[CategoryAxis alloc] init];
    categoryAxis.displayName = @"月份";
    categoryAxis.suffixName = @"月";
    categoryAxis.categoryField = @"categoryName";
    LinearAxis *linearAxis = [[LinearAxis alloc] init];
    linearAxis.displayName = @"价格";
    linearAxis.interval = 4;
    LineSeries *series = [[LineSeries alloc]init:[UIColor colorWithIndex:3]];
    series.valueField = @"name";
    series.displayName = @"月";
//    LineSeries *tseries = [[LineSeries alloc]init:[UIColor randomColor]];
//    tseries.valueField = @"sname";
//    LineSeries *lseries = [[LineSeries alloc]init:[UIColor randomColor]];
//    lseries.valueField = @"tname";
    [lineChart addSeries:series];
    series.displayName = @"销售量";
//    [lineChart addSeries:tseries];
//    [lineChart addSeries:lseries];
    lineChart.verticalAxis = linearAxis;
    lineChart.horizonAxis = categoryAxis;
    return lineChart;
}


+ (PieChart *) getPieChart : (CGContextRef)context
{
    PieChart *pieChart = [[PieChart alloc] init:context];
    PieSeries * pieSeries = [[PieSeries alloc] init];
    pieChart.radius = 100;
    pieSeries.valueField = @"name";
    pieSeries.labelField = @"categoryName";
    [pieChart addSeries:pieSeries];
    return pieChart;
}

+ (ColumnChart *) getMutilColumnChart : (CGContextRef)context
{
    ColumnChart * columnChart = [[ColumnChart alloc] init:context];
    [columnChart setPadding:50 paddingTop:20 paddingBottom:100 paddingRight:20];
    CategoryAxis * categoryAxis = [[CategoryAxis alloc] init];
    categoryAxis.displayName = @"月份";
    categoryAxis.suffixName = @"月";
    categoryAxis.categoryField = @"categoryName";
    LinearAxis *linearAxis = [[LinearAxis alloc] init];
    linearAxis.displayName = @"价格";
    linearAxis.interval = 4;
    ColumnSeries *series = [[ColumnSeries alloc]init:[UIColor colorWithIndex:1]];
    series.valueField = @"name";
    ColumnSeries *tseries = [[ColumnSeries alloc]init:[UIColor colorWithIndex:2]];
    tseries.valueField = @"sname";
    ColumnSeries *lseries = [[ColumnSeries alloc]init:[UIColor colorWithIndex:3]];
    lseries.valueField = @"tname";
    series.displayName = @"销售量";
    tseries.displayName = @"A";
    lseries.displayName = @"B";
    [columnChart addSeries:series];
    [columnChart addSeries:tseries];
    [columnChart addSeries:lseries];
    columnChart.verticalAxis = linearAxis;
    columnChart.horizonAxis = categoryAxis;
    return columnChart;
}

+ (BarChart *) getMutilBarChart : (CGContextRef)context
{
    BarChart * barChart = [[BarChart alloc] init:context];
    [barChart setPadding:50 paddingTop:20 paddingBottom:100 paddingRight:20];
    CategoryAxis * categoryAxis = [[CategoryAxis alloc] init];
    categoryAxis.displayName = @"月份";
    categoryAxis.suffixName = @"月";
    categoryAxis.categoryField = @"categoryName";
    categoryAxis.titleAngle = 90;
    LinearAxis *linearAxis = [[LinearAxis alloc] init];
    linearAxis.displayName = @"价格";
    linearAxis.interval = 2;
    linearAxis.titleAngle = 0;
    AnimBarSeries * sseries = [[AnimBarSeries alloc]init:[UIColor colorWithIndex:6]];
    sseries.valueField = @"sname";
    AnimBarSeries * tseries = [[AnimBarSeries alloc]init:[UIColor colorWithIndex:13]];
    tseries.valueField = @"name";
    [barChart addSeries:sseries];
    sseries.displayName = @"销售量";
    tseries.displayName = @"B";
    [barChart addSeries:tseries];
    barChart.verticalAxis = categoryAxis;
    barChart.horizonAxis = linearAxis;
    return barChart;}



+ (LineChart *) getMutilLineChart : (CGContextRef)context
{
    LineChart *lineChart = [[LineChart alloc] init:context];
    [lineChart setPadding:50 paddingTop:20 paddingBottom:100 paddingRight:20];
    CategoryAxis * categoryAxis = [[CategoryAxis alloc] init];
    categoryAxis.displayName = @"月份";
    categoryAxis.suffixName = @"月";
    categoryAxis.categoryField = @"categoryName";
    LinearAxis *linearAxis = [[LinearAxis alloc] init];
    linearAxis.displayName = @"价格";
    linearAxis.interval = 4;
    LineSeries *series = [[LineSeries alloc]init:[UIColor colorWithIndex:1]];
    series.valueField = @"name";
    LineSeries *tseries = [[LineSeries alloc]init:[UIColor colorWithIndex:2]];
    tseries.valueField = @"sname";
    LineSeries *lseries = [[LineSeries alloc]init:[UIColor colorWithIndex:3]];
    lseries.valueField = @"tname";
    [lineChart addSeries:series];
    series.displayName = @"销售量";
    lseries.displayName = @"A";
    tseries.displayName = @"B";
    [lineChart addSeries:tseries];
    [lineChart addSeries:lseries];
    lineChart.verticalAxis = linearAxis;
    lineChart.horizonAxis = categoryAxis;
    return lineChart;
}

+ (CombinedChart *) getLineAndColumnChart : (CGContextRef)context
{
    CombinedChart *combinedChart = [[CombinedChart alloc] init:context];
    [combinedChart setPadding:50 paddingTop:20 paddingBottom:100 paddingRight:20];
    CategoryAxis * categoryAxis = [[CategoryAxis alloc] init];
    categoryAxis.displayName = @"月份";
    categoryAxis.suffixName = @"月";
    categoryAxis.categoryField = @"categoryName";
    LinearAxis *linearAxis = [[LinearAxis alloc] init];
    linearAxis.displayName = @"价格";
    linearAxis.interval = 4;
    AnimColumnSeries *series = [[AnimColumnSeries alloc]init:[UIColor colorWithIndex:1]];
    series.valueField = @"name";
    AnimColumnSeries *tseries = [[AnimColumnSeries alloc]init:[UIColor colorWithIndex:2]];
    tseries.valueField = @"sname";
    AnimLineSeries *lseries = [[AnimLineSeries alloc]init:[UIColor colorWithIndex:3]];
    lseries.valueField = @"tname";
    series.displayName = @"销售量";
    tseries.displayName = @"A";
    lseries.displayName = @"B";
    [combinedChart addSeries:series];
    [combinedChart addSeries:tseries];
    [combinedChart addSeries:lseries];
    combinedChart.verticalAxis = linearAxis;
    combinedChart.horizonAxis = categoryAxis;
    return combinedChart;
}

+ (RadarChart *) getRadarChart : (CGContextRef)context;
{
    RadarChart *radarChart = [[RadarChart alloc] init:context];
    [radarChart setPadding:20 paddingTop:20 paddingBottom:30 paddingRight:20];
    RadarAxis * nameAxis = [[RadarAxis alloc] init : @"name"];
    nameAxis.displayName = @"F";
    RadarAxis * tNameAxis = [[RadarAxis alloc] init : @"tname"];
    tNameAxis.displayName = @"E";
    RadarAxis * smeAxis = [[RadarAxis alloc] init : @"sname"];
    smeAxis.displayName = @"D";
    RadarAxis * vmeAxis = [[RadarAxis alloc] init : @"vname"];
    vmeAxis.displayName = @"C";
    RadarAxis * emeAxis = [[RadarAxis alloc] init : @"vname"];
    emeAxis.displayName = @"B";
    RadarAxis * fmeAxis = [[RadarAxis alloc] init : @"sname"];
    fmeAxis.displayName = @"A";
    [radarChart addAxis:nameAxis];
    [radarChart addAxis:tNameAxis];
    [radarChart addAxis:smeAxis];
    [radarChart addAxis:vmeAxis];
    [radarChart addAxis:emeAxis];
    [radarChart addAxis:fmeAxis];
    return radarChart;
}

@end
