//
//  ChartFacade.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-7-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "ChartFacade.h"
#import "ChartParser.h"
#import "ChartCreator.h"
#import "ReflectUtils.h"
#import "JSONKit.h"
@implementation ChartFacade

- (id) init : (CGContextRef)mContext;
{
    self = [super init];
    if (self)
    {
        context = mContext;
    }
    return self;
}

- (ChartView *) createChart : (NSString *) chartJson frame : (CGRect) frame
{
    ChartParser * chartParser = [[ChartParser alloc] init:chartJson];
    ChartModel * chartModel = [chartParser parserHandler];
    chart = [ChartCreator getChart:chartModel context:context];
    chartView = [[ChartView alloc] initWithFrame:frame];
    chartView.chart = chart;
    return chartView;
}

- (void) refreshDataProvier : (NSString *) dataProvider
{
    if (dataProvider == nil || chart == nil)
    {
        return;
    }
    NSDictionary * json = [dataProvider objectFromJSONString];
    NSObject * result = [json objectForKey:@"dataProvider"];
    
    if ([result isKindOfClass:[NSMutableArray class]])
    {
        [chart setDataProviderHandler : (NSMutableArray *)result];
        return;
    }
    if ([chart isKindOfClass:[DialChart class]])
    {
        DialChart * dialChart = (DialChart *)chart;
        [dialChart setDialValueHandler:[[NSString stringWithFormat:@"%@",result] floatValue]];
    }
}


@end
