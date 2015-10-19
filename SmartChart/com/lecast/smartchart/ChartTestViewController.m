//
//  ChartTestViewController.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-17.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "ChartTestViewController.h"
#import "PieSeries.h"
#import "PieChart.h"
#import "JSONKit.h"
#import "ChartView.h"
#import "ChartViewViewController.h"
#import "ChartVO.h"
@interface ChartTestViewController ()

@end

@implementation ChartTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void) initData
{
    NSArray * chartNames = [[NSArray alloc] initWithObjects:@"线图",@"多线图", @"柱图",@"多柱图",@"线柱混合图",@"水平柱状图",@"水平多柱状图", @"区域图", @"饼图", @"仪表盘", @"雷达图",nil];//@"雷达图"
     NSArray * chartTypes = [[NSArray alloc] initWithObjects:@"LineChart",@"MutilLineChart", @"CoumlnChart",@"MutilColumnChart",@"MutilLineAndColumnChart",@"BarChart" ,@"MutilBarChart", @"AreaChart", @"PieChart", @"DialChart",@"RadarChart",nil]; //
    dataSources = [[NSMutableArray alloc] init];
    for (int index = 0; index < [chartNames count]; index ++)
    {
        ChartVO * chartVO = [[ChartVO alloc] init];
        chartVO.chartName = [chartNames objectAtIndex:index];
        chartVO.chartType = [chartTypes objectAtIndex:index];
        [dataSources addObject:chartVO];
    }
}

- (void)viewDidLoad
{
    [self initData];
    ChartView * chartView = [[ChartView alloc] initWithFrame:self.view.frame];
    chartTableView = [[UITableView alloc] initWithFrame:self.view.frame];
    chartTableView.dataSource = self;
    chartTableView.delegate = self;
    [self.view addSubview:chartTableView];
  //  [self.view addSubview:chartView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition
{
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChartViewViewController * chartViewController = [[ChartViewViewController alloc] init];
    chartViewController.chartType = [[dataSources objectAtIndex:[indexPath row]] chartType];
    [self presentViewController:chartViewController animated:YES completion:nil];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSources count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier = @"ChartIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [[dataSources objectAtIndex:row] chartName];
	return cell;
}

@end
