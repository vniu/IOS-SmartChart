//
//  CartesianChart.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-17.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "ChartBase.h"
#import "GridLine.h"
#import "CartesianSeries.h"

@interface CartesianChart : ChartBase
{
    BOOL showYGridLine;
    BOOL showXGridLine;
    GridLine * gridLine;
    Stroke * axisStroke;
    AxisBase * horizonAxis;
    AxisBase * verticalAxis;
    BOOL animEnable;
}
- (NSMutableArray *) getValueFields;
@end

@interface  CartesianChart(protected)
- (void) drawAxis : (UIView *) view;
- (void) drawXAxis : (UIView *) view;
- (void) drawYAxis : (UIView *) view;
- (void) drawXAxisLabel : (UIView *) view;
- (void) drawYAxisLabel : (UIView *) view;
- (void) setAxisValueFields;
- (void) setSeriesProperty : (CartesianSeries *) series;
- init : (CGContextRef)mContext;
@end
