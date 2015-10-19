//
//  ChartParser.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-7-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "ChartParser.h"
#import "JSONKit.h"
#import "ReflectUtils.h"
#import "SeriesModel.h"
@implementation ChartParser

- (id) init : (NSString * ) mChartJson
{
    self = [super init];
    if (self)
    {
        chartJson = mChartJson;
    }
    return self;
}

- (ChartModel *) parserHandler
{
    ChartModel * chartModel;
    if (chartJson == nil)
    {
        return nil;
    }
    chartModel  = [[ChartModel alloc] init];
    NSMutableDictionary * chartModelJson = [chartJson objectFromJSONString];
    chartModel.name = [chartModelJson objectForKey:@"chart"];
    chartModel.titleName = [ReflectUtils getStringValue:chartModelJson property:@"titleName"];
    chartModel.fontSize = [ReflectUtils getIntValue:chartModelJson property:@"fontSize"];
    if ([chartModelJson objectForKey:@"padding"] != nil)
    {
        NSMutableDictionary * padding = [chartModelJson objectForKey:@"padding"];
        chartModel.paddingRight = [ReflectUtils getIntValue:padding property:@"paddingRight"];
        chartModel.paddingLeft = [ReflectUtils getIntValue:padding property:@"paddingLeft"];
        chartModel.paddingTop = [ReflectUtils getIntValue:padding property:@"paddingTop"];
        chartModel.paddingBottom = [ReflectUtils getIntValue:padding property:@"paddingBottom"];
    }
    if ([chartModelJson objectForKey:@"series"] != nil)
    {
        NSMutableArray * series = [chartModelJson objectForKey:@"series"];
        for (NSMutableDictionary * element in series)
        {
            SeriesModel * seriesModel = [[SeriesModel alloc] init];
            seriesModel.name = [element objectForKey:@"name"];
            seriesModel.displayName = [ReflectUtils getStringValue:element property:@"displayName"];
            seriesModel.valueField = [ReflectUtils getStringValue:element property:@"valueField"];
            seriesModel.labelField = [ReflectUtils getStringValue:element property:@"labelField"];
            seriesModel.suffixName = [ReflectUtils getStringValue:element property:@"suffixName"];
            seriesModel.color = [ReflectUtils getStringValue:element property:@"color"];
            seriesModel.strokeWidth = [ReflectUtils getIntValue:element property:@"strokeWidth"];
            [chartModel addSeriesModel:seriesModel];
        }
    }
    if ([chartModelJson objectForKey:@"verticalAxis"] != nil)
    {
        AxisModel *verticalAxisModel = [[AxisModel alloc] init];
        NSMutableDictionary * verticalAxis = [chartModelJson objectForKey:@"verticalAxis"];
        verticalAxisModel.textAngle = [ReflectUtils getIntValue:verticalAxis property:@"textAngle"];
        verticalAxisModel.name = [ReflectUtils getStringValue:verticalAxis property:@"name"];
        verticalAxisModel.displayName = [ReflectUtils getStringValue:verticalAxis property:@"displayName"];
        verticalAxisModel.valueField = [ReflectUtils getStringValue:verticalAxis property:@"valueField"];
        verticalAxisModel.categoryField = [ReflectUtils getStringValue:verticalAxis property:@"categoryField"];
         chartModel.verticalAxisModel = verticalAxisModel;
    }
    if ([chartModelJson objectForKey:@"horizonAxis"] != nil)
    {
        AxisModel * horizonalAxisModel = [[AxisModel alloc] init];
        NSMutableDictionary * horizonalAxis = [chartModelJson objectForKey:@"horizonAxis"];
        horizonalAxisModel.textAngle = [ReflectUtils getIntValue:horizonalAxis property:@"textAngle"];
        horizonalAxisModel.name = [ReflectUtils getStringValue:horizonalAxis property:@"name"];
        horizonalAxisModel.displayName = [ReflectUtils getStringValue:horizonalAxis property:@"displayName"];
        horizonalAxisModel.valueField = [ReflectUtils getStringValue:horizonalAxis property:@"valueField"];
        horizonalAxisModel.categoryField = [ReflectUtils getStringValue:horizonalAxis property:@"categoryField"];
        chartModel.horizonalAxisModel = horizonalAxisModel;
    }
    if ([chartModelJson objectForKey:@"dialAxis"] != nil)
    {
        AxisModel * dialAxisModel = [[AxisModel alloc] init];
        NSMutableDictionary * dialAxis = [chartModelJson objectForKey:@"dialAxis"];
        dialAxisModel.name = [ReflectUtils getStringValue:dialAxis property:@"name"];
        dialAxisModel.maxValue = [ReflectUtils getIntValue:dialAxis property:@"maxValue"];
        dialAxisModel.minValue = [ReflectUtils getIntValue:dialAxis property:@"minValue"];
        chartModel.dialAxisModel = dialAxisModel;
    }
    if ([chartModelJson objectForKey:@"chartLegend"] != nil)
    {
        chartModel.chartLegendName = [chartModelJson objectForKey:@"chartLegend"];
    }
    
    
    
    return chartModel;
}

@end
