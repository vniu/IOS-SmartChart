//
//  ChartView.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-20.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChart.h"
#import "IChartTouchListener.h"
#import "LineChart.h"
#import "DialChart.h"
#import "AreaChart.h"
@interface ChartView : UIView<UIGestureRecognizerDelegate>
{
    PieChart * pieChart;
    id<IChartTouchListener> chartTouchListener;
    CartesianChart * lineChart;
    DialChart * dialChart;
    AreaChart * areaChart;
    ChartBase * chart;
}
@property (nonatomic, retain) id<IChartTouchListener> chartTouchListener;
@property (nonatomic, retain) ChartBase * chart;
- (void) drawColumnChart : (CGRect) rect dataProvider : (NSMutableArray *) mDataProvider;
- (void) drawLineChart : (CGRect) rect dataProvider : (NSMutableArray *) mDataProvider;
@end
