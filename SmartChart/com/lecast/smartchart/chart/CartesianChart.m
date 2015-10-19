//
//  CartesianChart.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-17.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "CartesianChart.h"
#import "CategoryAxis.h"
#import "LinearAxis.h"
#import "Line.h"
#import "DrawUtils.h"
#import "AxisLabel.h"
#import "NSString+NSChartLabelDraw.h"
@implementation CartesianChart
@synthesize horizonAxis;
@synthesize verticalAxis;

- init : (CGContextRef)mContext
{
    self = [super init];
    if (self)
    {
        context = mContext;
        horizonAxis = [[CategoryAxis alloc] init];
        verticalAxis = [[LinearAxis alloc] init];
        showXGridLine = true;
        showYGridLine = true;
        UIColor * defautAxisColor = [UIColor colorWithRed:186.0f/255 green:206.0f/255 blue:220.0f/255 alpha:1.0f];
        axisStroke = [[Stroke alloc] init:defautAxisColor textColor:[UIColor blackColor]];
    }
    return self;
}
-(void) onDraw : (UIView *)view
{
    [super onDraw:view];
    if (dataProvider != nil)
    {
        gridLine = [[GridLine alloc] init:context];
        [pointMapping clear];
        [self setAxisValueFields];
        [verticalAxis setDataProviderHandler:dataProvider];
        [horizonAxis setDataProviderHandler:dataProvider];
        gridLine.lineStroke = axisStroke;
        [self drawAxis:view];
        [self drawSeriesHandler:view];
    }
    
}

- (void) drawAxis : (UIView *) view
{
    [self drawXAxis:view];
    [self drawYAxis:view];
}

- (void) drawXAxis : (UIView *) view
{
    int width = view.frame.size.width;
    int height = view.frame.size.height;
    CGFloat startX = paddingLeft;
    CGFloat startY = height - paddingBottom;
    CGFloat endX = width - paddingRight;
    CGPoint startPoint = CGPointMake(startX, startY);
    CGPoint endPoint = CGPointMake(endX, startY);
    Line * horLine = [[Line alloc] initWithPoint:startPoint endPoint:endPoint];
    horLine.strokeColor = axisStroke.strokeColor;
    horLine.lineWidth = 2;
    [horLine drawHandler:context];
    [self drawXAxisLabel:view];
}

- (void) drawYAxis : (UIView *) view
{
    int height = view.frame.size.height;
    CGFloat startX = paddingLeft;
    CGFloat startY = height - paddingBottom;
    CGFloat endY = paddingTop;
    CGPoint startPoint = CGPointMake(startX, startY);
    CGPoint endPoint = CGPointMake(startX, endY);
    Line * verLine = [[Line alloc] initWithPoint:startPoint endPoint:endPoint];
    verLine.strokeColor = axisStroke.strokeColor;
    verLine.lineWidth = 2;
    [verLine drawHandler:context];
    [self drawYAxisLabel:view];
}

- (void) drawXAxisLabel : (UIView *) view
{
    int height = view.frame.size.height;
    int width = view.frame.size.width;
    int areaRectWidth = width - paddingRight - paddingLeft;
    AxisLabelSetting * horAxisLabelSetting = [horizonAxis axisLabelSetting];
    CGFloat bottom = height - paddingBottom;
    NSMutableArray * axisLables = horAxisLabelSetting.labels;
    for (AxisLabel *label in axisLables)
    {
        CGFloat xLabel = label.position * areaRectWidth + paddingLeft;
        CGSize textSize = [DrawUtils getTextRect:label.text fontSize:fontSize];
        CGFloat lastXLabel = xLabel - textSize.width/2;
        CGFloat lastYLabel = bottom + fontSize * 2/3;
        //CGRect textRect = CGRectMake(lastXLabel, lastYLabel, textSize.width, textSize.height);
//        [label.text drawInRect:textRect withFont:[UIFont systemFontOfSize:fontSize] lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentLeft];
        
        [label.text drawWithBasePoint:CGPointMake(lastXLabel, lastYLabel) andAngle:horizonAxis.textAngle andFont:[UIFont systemFontOfSize:fontSize]];
        
        if (showXGridLine)
        {
            CGPoint startPoint = CGPointMake(xLabel, bottom);
            CGPoint endPoint = CGPointMake(xLabel, paddingTop);
            [gridLine drawGridLine:startPoint endPoint:endPoint];
        }
        [gridLine drawLine:CGPointMake(xLabel, bottom) endPoint:CGPointMake(xLabel, bottom + fontSize/3) lineWidth:2];
    }
    if (horizonAxis.displayName != nil)
    {
        CGSize fontRect = [DrawUtils getTextRect:horizonAxis.displayName fontSize:fontSize];
        float displayX = paddingLeft + areaRectWidth/2;
        float displayY = bottom + 1.5 * fontRect.height;
        [horizonAxis.displayName drawWithBasePoint:CGPointMake(displayX , displayY) andAngle:horizonAxis.titleAngle andFont:[UIFont systemFontOfSize:fontSize]];
       // [DrawUtils drawText:horizonAxis.displayName point:CGPointMake(displayX,displayY) fontSize:fontSize];
    }
}

- (void) drawYAxisLabel : (UIView *) view
{
    int height = view.frame.size.height;
    int width = view.frame.size.width;
    int areaRectHeight = height - paddingBottom - paddingTop;
    float bottom = height - paddingBottom;
    NSMutableArray * verLables = verticalAxis.axisLabels;
    float right = width - paddingRight;
    for (AxisLabel *label in verLables)
    {
        float yLabel = bottom - label.position * areaRectHeight;
        [gridLine drawLine:CGPointMake(paddingLeft - 5, yLabel) endPoint:CGPointMake(paddingLeft, yLabel) lineWidth:2];
        [label.text drawWithBasePoint:CGPointMake(paddingLeft - fontSize * 4/3  , yLabel) andAngle:verticalAxis.textAngle andFont:[UIFont systemFontOfSize:fontSize]];
        if (showYGridLine && label.position != 0)
        {
            CGPoint startPoint = CGPointMake(paddingLeft, yLabel);
            CGPoint endPoint = CGPointMake(right, yLabel);
            [gridLine drawGridLine : startPoint endPoint : endPoint];
        }
    }
    if (verticalAxis.displayName != nil)
    {
        CGSize fontRect = [DrawUtils getTextRect:verticalAxis.displayName fontSize:fontSize];
        float displayX = paddingLeft - fontSize * 4 / 2 - fontRect.width/2;
        float displayY = paddingTop + areaRectHeight / 2 - fontRect.height;
        [verticalAxis.displayName drawWithBasePoint:CGPointMake(displayX + 5 , displayY) andAngle:verticalAxis.titleAngle andFont:[UIFont systemFontOfSize:fontSize]];
        //[DrawUtils drawText:verticalAxis.displayName point:CGPointMake(displayX - 10, displayY) fontSize:fontSize ];
        
//        [DrawUtils drawTextOnDegrees:context text:verticalAxis.displayName point:CGPointMake(displayX + 10, displayY)  fontSize:fontSize degrees:90];
    }
}

- (void) setAxisValueFields
{
    if ([verticalAxis isKindOfClass:[LinearAxis class]])
    {
        LinearAxis * linearAxis = (LinearAxis *) verticalAxis;
        linearAxis.valueFields = [self getValueFields];
    }
    else if ([horizonAxis isKindOfClass:[LinearAxis class]])
    {
        LinearAxis * linearAxis = (LinearAxis *) horizonAxis;
        linearAxis.valueFields = [self getValueFields];
    }
}

- (void) setSeriesProperty : (CartesianSeries *) series
{
    [series setOffset:offsetX offsetY:offsetY];
    series.scale = scale;
    series.chartView = chartView;
    series.context = context;
    series.fontSize = fontSize;
    series.pointMapping = pointMapping;
    [series setPadding:paddingLeft paddingTop:paddingTop paddingBottom:paddingBottom paddingRight:paddingRight];
    series.verticalAxis = verticalAxis;
    series.horizontalAxis = horizonAxis;
    [series setDataProviderHandler:dataProvider];
}

- (LocalPoint *)  getPointForScreenCoordinate: (LocalPoint *) screenPoint
{
    return [pointMapping getClickPoint:screenPoint];
}

- (NSMutableArray *) getValueFields
{
    NSMutableArray * valueFields = [[NSMutableArray alloc] init];
    for (Series * series in mSeries)
    {
        [valueFields addObject:series.valueField];
    }
    return valueFields;
}

@end
