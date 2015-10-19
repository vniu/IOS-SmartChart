//
//  ChartFactory.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-7.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChartBase.h"
#import "BarChart.h"
#import "PieChart.h"
#import "LineChart.h"
#import "DialChart.h"
#import "CombinedChart.h"
#import "ColumnChart.h"
#import "AreaChart.h"
#import "RadarChart.h"
@interface ChartFactory : NSObject
{
  
}

+ (ChartBase *) getChart : (NSString *) chartType context : (CGContextRef)context;
+ (BarChart *) getBarChart : (CGContextRef)context;
+ (DialChart *) getDialChart : (CGContextRef)context;
+ (AreaChart *) getAreaChart : (CGContextRef)context;
+ (ColumnChart *) getColumnChart : (CGContextRef)context;
+ (LineChart *) getLineChart : (CGContextRef)context;
+ (PieChart *) getPieChart : (CGContextRef)context;
+ (ColumnChart *) getMutilColumnChart : (CGContextRef)context;
+ (BarChart *) getMutilBarChart: (CGContextRef)context;
+ (LineChart *) getMutilLineChart : (CGContextRef)context;
+ (CombinedChart *) getLineAndColumnChart : (CGContextRef)context;
+ (RadarChart *) getRadarChart : (CGContextRef)context;


@end
