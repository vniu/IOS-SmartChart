//
//  ChartView.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-20.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "ChartView.h"
#import "PieChart.h"
#import "PieSeries.h"
#import "JSONKit.h"
#import "CartesianChart.h"
#import "ColumnSeries.h"
#import "LineChart.h"
#import "LineSeries.h"
#import "ColumnChart.h"
#import "AnimColumnSeries.h"
#import "UIColor+ChartColor.h"
#import "CombinedChart.h"
#import "AnimLineSeries.h"
#import "BarChart.h"
#import "BarSeries.h"
#import "AnimBarSeries.h"
#import "DialAxis.h"
#import "DialSeries.h"
#import "AreaChart.h"
#import "AreaSeries.h"

@implementation ChartView

@synthesize chartTouchListener;
@synthesize chart;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleViewHandler:)];
        [pinchGesture setDelegate:self];
        [self addGestureRecognizer:pinchGesture];
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panViewHandler:)];
        [panGesture setMaximumNumberOfTouches:2];
        [panGesture setDelegate:self];
        [self addGestureRecognizer:panGesture];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSString * json = @"[{\"tname\":2,\"sname\":2,\"categoryName\":1,\"name\":1},{\"tname\":6,\"sname\":11,\"categoryName\":2,\"name\":2},{\"tname\":8.071067811865476,\"sname\":15.142135623730951,\"categoryName\":3,\"name\":2.414213562373095},{\"tname\":9.660254037844386,\"sname\":18.32050807568877,\"categoryName\":4,\"name\":2.732050807568877},{\"tname\":11,\"sname\":21,\"categoryName\":5,\"name\":3},{\"tname\":12.180339887498949,\"sname\":23.360679774997898,\"categoryName\":6,\"name\":3.23606797749979},{\"tname\":13.24744871391589,\"sname\":25.49489742783178,\"categoryName\":7,\"name\":3.449489742783178},{\"tname\":14.228756555322953,\"sname\":27.457513110645905,\"categoryName\":8,\"name\":3.6457513110645907}]";
//    NSMutableArray * dataProvider = [json objectFromJSONString];
//    [self drawLineChart:rect dataProvider:dataProvider];    
    UIGraphicsEndImageContext();
    
   NSMutableArray * layersToRemove = [NSMutableArray arrayWithArray:self.layer.sublayers];
    [layersToRemove  enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         [obj removeFromSuperlayer];
     }];
    if (chart != nil)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        chart.context = context;
        [chart onDraw:self];
    }
}

- (void) drawLineChart : (CGRect) rect dataProvider : (NSMutableArray *) mDataProvider
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    lineChart = [[LineChart alloc] init:context];
    [lineChart setPadding:50 paddingTop:20 paddingBottom:100 paddingRight:20];
    CategoryAxis * categoryAxis = [[CategoryAxis alloc] init];
    categoryAxis.displayName = @"月份";
    categoryAxis.suffixName = @"月";
    categoryAxis.categoryField = @"categoryName";
    LinearAxis *linearAxis = [[LinearAxis alloc] init];
    linearAxis.displayName = @"价格";
    linearAxis.interval = 4;
    LineSeries *series = [[LineSeries alloc]init:[UIColor randomColor]];
    series.valueField = @"name";
    LineSeries *tseries = [[LineSeries alloc]init:[UIColor randomColor]];
    tseries.valueField = @"sname";
    LineSeries *lseries = [[LineSeries alloc]init:[UIColor randomColor]];
    lseries.valueField = @"tname";
    [lineChart addSeries:series];
    [lineChart addSeries:tseries];
    [lineChart addSeries:lseries];
    lineChart.verticalAxis = linearAxis;
    lineChart.horizonAxis = categoryAxis;
    lineChart.dataProvider = mDataProvider;
    [lineChart onDraw:self];
}

- (void) drawAreaChart : (CGRect) rect dataProvider : (NSMutableArray *) mDataProvider
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    areaChart = [[AreaChart alloc] init:context];
    [areaChart setPadding:50 paddingTop:20 paddingBottom:100 paddingRight:20];
    CategoryAxis * categoryAxis = [[CategoryAxis alloc] init];
    categoryAxis.displayName = @"月份";
    categoryAxis.suffixName = @"月";
    categoryAxis.categoryField = @"categoryName";
    LinearAxis *linearAxis = [[LinearAxis alloc] init];
    linearAxis.displayName = @"价格";
    linearAxis.interval = 10;
    
    AreaSeries *sseries = [[AreaSeries alloc]init];
    sseries.valueField = @"sname";
    
    [areaChart addSeries:sseries];
    //[lineChart addSeries:tseries];
    // [lineChart addSeries:sseries];
    areaChart.verticalAxis = linearAxis;
    areaChart.horizonAxis = categoryAxis;
    areaChart.dataProvider = mDataProvider;
    [areaChart onDraw:self];
}

- (void) drawColumnChart : (CGRect) rect dataProvider : (NSMutableArray *) mDataProvider
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    lineChart = [[LineChart alloc] init:context];
    [lineChart setPadding:50 paddingTop:20 paddingBottom:100 paddingRight:20];
    CategoryAxis * categoryAxis = [[CategoryAxis alloc] init];
    categoryAxis.displayName = @"月份";
    categoryAxis.suffixName = @"月";
    categoryAxis.categoryField = @"categoryName";
    LinearAxis *linearAxis = [[LinearAxis alloc] init];
    linearAxis.displayName = @"价格";
    linearAxis.interval = 10;
    
    LineSeries *sseries = [[LineSeries alloc]init:[UIColor randomColor]];
    sseries.valueField = @"sname";
    
    ColumnSeries *tseries = [[ColumnSeries alloc]init:[UIColor blueColor]];
    tseries.valueField = @"tname";
    
    ColumnSeries *lseries = [[ColumnSeries alloc]init:[UIColor purpleColor]];
    lseries.valueField = @"name";
    [lineChart addSeries:lseries];
    //[lineChart addSeries:tseries];
   // [lineChart addSeries:sseries];
    
    lineChart.verticalAxis = linearAxis;
    lineChart.horizonAxis = categoryAxis;
    lineChart.dataProvider = mDataProvider;
    [lineChart onDraw:self];
}


- (void) drawBarChart : (CGRect) rect dataProvider : (NSMutableArray *) mDataProvider
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    lineChart = [[BarChart alloc] init:context];
    [lineChart setPadding:50 paddingTop:20 paddingBottom:100 paddingRight:20];
    CategoryAxis * categoryAxis = [[CategoryAxis alloc] init];
    categoryAxis.displayName = @"月份";
    categoryAxis.suffixName = @"月";
    categoryAxis.categoryField = @"categoryName";
    LinearAxis *linearAxis = [[LinearAxis alloc] init];
    linearAxis.displayName = @"价格";
    linearAxis.interval = 2;
    
    AnimBarSeries * sseries = [[AnimBarSeries alloc]init:[UIColor randomColor]];
    sseries.valueField = @"sname";
    
    AnimBarSeries * tseries = [[AnimBarSeries alloc]init:[UIColor randomColor]];
    tseries.valueField = @"name";
    
//    AnimLineSeries *tseries = [[AnimLineSeries alloc]init:[UIColor blueColor]];
//    tseries.valueField = @"tname";
//    
//    AnimLineSeries *lseries = [[AnimLineSeries alloc]init:[UIColor redColor]];
//    lseries.valueField = @"name";
    
//    [lineChart addSeries:lseries];
   // [lineChart addSeries:tseries];
    [lineChart addSeries:sseries];
    lineChart.verticalAxis = categoryAxis;
    lineChart.horizonAxis = linearAxis;
    lineChart.dataProvider = mDataProvider;
    [lineChart onDraw:self];
}

- (void) drawDialChart : (CGRect) rect dataProvider : (NSMutableArray *) mDataProvider
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    DialAxis * dialAxis = [[DialAxis alloc] init];
    DialSeries * dialSeries = [[DialSeries alloc] init];
    dialChart = [[DialChart alloc] init:context dialAxis:dialAxis];
    [dialChart addSeries:dialSeries];
    [dialChart onDraw:self];
}


- (void) drawPieChart : (CGRect) rect dataProvider : (NSMutableArray *) mDataProvider
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    pieChart = [[PieChart alloc] init:context];
    PieSeries * pieSeries = [[PieSeries alloc] init];
    pieChart.radius = 100;
    pieSeries.valueField = @"name";
    pieSeries.labelField = @"categoryName";
    [pieChart addSeries:pieSeries];
    pieChart.dataProvider = mDataProvider;
    [pieChart onDraw:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    LocalPoint * screenPoint = [[LocalPoint alloc] init];
    screenPoint.x = point.x;
    screenPoint.y = point.y;
    LocalPoint * touchPoint = [chart getPointForScreenCoordinate:screenPoint];
    
    if ([chart isKindOfClass:[PieChart class]])
    {
        [(PieChart *)chart searchIndexByTouchPoint:touchPoint];
    }
    
    if (touchPoint.value != nil && chartTouchListener != nil && [chartTouchListener respondsToSelector:@selector(execute:)])
    {
        [chartTouchListener execute:touchPoint.value];
    }
    
    if (touchPoint.value != nil)
    {
        
        UIAlertView* customAlert = [[UIAlertView alloc] initWithTitle:@"点击提示"
                                                              message:[NSString stringWithFormat:@"%@",touchPoint.value]
                                                             delegate:nil
                                                    cancelButtonTitle:@"确定"
                                                    otherButtonTitles:nil];
        [customAlert show];
    }
    NSLog(@"Touch Point%@", touchPoint.value);
    [self touchesCancelled:touches withEvent:event];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer.view != self)
        return NO;
    if (gestureRecognizer.view != otherGestureRecognizer.view)
        return NO;
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] || [otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
        return NO;
    return YES;
}

- (void)panViewHandler:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *piece = [gestureRecognizer view];
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
    }
}

- (void)scaleViewHandler:(UIPinchGestureRecognizer *)gestureRecognizer
{
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged)
    {
        [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], [gestureRecognizer scale], [gestureRecognizer scale]);
        [gestureRecognizer setScale:1];
    }
}




- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}

@end
