//
//  ChartCreator.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-7-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "ChartCreator.h"
#import "ChartConstants.h"
#import "LineChart.h"
#import "ColumnChart.h"
#import "BarChart.h"
#import "CombinedChart.h"
#import "PieChart.h"
#import "DialChart.h"
#import "AreaChart.h"
#import "AxisCreator.h"
#import "ChartLegendCreator.h"
@implementation ChartCreator


+ (ChartBase *) getChart : (ChartModel * ) chartModel context : (CGContextRef) mContext
{
    ChartBase * chart = [self createChart:chartModel context:mContext];
    if (chart == nil)
    {
        return chart;
    }
    [self composeChartHandler:chart chartModel:chartModel context:mContext];
    return chart;
}
 
+ (void) composeChartHandler : (ChartBase *) chart chartModel : (ChartModel *) chartModel context : (CGContextRef) mContext
{
    for (SeriesModel * seriesModel in chartModel.seriesModels)
    {
        [chart addSeries:[seriesModel getSeries]];
    }
    chart.fontSize = chartModel.fontSize;
    chart.paddingBottom = chartModel.paddingBottom;
    chart.paddingLeft = chartModel.paddingLeft;
    chart.paddingTop = chartModel.paddingTop;
    chartModel.paddingRight = chartModel.paddingRight;
    if (chartModel.horizonalAxisModel != nil)
    {
        chart.horizonAxis = [AxisCreator getAxis:chartModel.horizonalAxisModel];
    }
    if (chartModel.verticalAxisModel != nil)
    {
        chart.verticalAxis = [AxisCreator getAxis:chartModel.verticalAxisModel];
    }
    if (chartModel.chartLegendName != nil)
    {
        chart.chartLegend = [ChartLegendCreator getLegend:chart legendName:chartModel.chartLegendName];
    }
    if (chartModel.dialAxisModel != nil)
    {
        DialChart * dialChart = (DialChart *)chart;
        dialChart.dialAxis = (DialAxis *) [AxisCreator getAxis:chartModel.dialAxisModel];
    }
    
}

+ (ChartBase *) createChart : (ChartModel *) chartModel context : (CGContextRef) mContext
{
    ChartBase * chart;
    if (chartModel.name == nil)
    {
        return nil;
    }
    if ([chartModel.name isEqualToString:kLineChart])
    {
        chart = [[LineChart alloc] init:mContext];
    }
    else if ([chartModel.name isEqualToString:kColumnChart])
    {
        chart = [[ColumnChart alloc] init:mContext];
    }
    else if ([chartModel.name isEqualToString:kBarChart])
    {
        chart = [[BarChart alloc] init:mContext];
    }
    else if ([chartModel.name isEqualToString:kCombineChart])
    {
        chart = [[CombinedChart alloc] init:mContext];
    }
    else if ([chartModel.name isEqualToString:kPieChart])
    {
        chart = [[PieChart alloc] init:mContext];
    }
    else if ([chartModel.name isEqualToString:kDialChart])
    {
        chart = [[DialChart alloc] init:mContext];
    }
    else if ([chartModel.name isEqualToString:kAreaChart])
    {
        chart = [[AreaChart alloc] init:mContext];
    }
    return chart;
}



@end
