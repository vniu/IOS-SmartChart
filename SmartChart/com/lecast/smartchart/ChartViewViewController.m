//
//  ChartViewViewController.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "ChartViewViewController.h"
#import "ChartFactory.h"
#import "ChartBase.h"
#import "ChartView.h"
#import "JSONKit.h"
@interface ChartViewViewController ()

@end

@implementation ChartViewViewController

@synthesize chartType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    fisrtCircle = false;
    dataChanged = YES;
    scale = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    NSString * json = @"[{\"tname\":2,\"sname\":2,\"categoryName\":1,\"name\":1,\"vname\":3},{\"tname\":6,\"sname\":11,\"categoryName\":2,\"name\":2, \"vname\":5},{\"tname\":8.071067811865476,\"sname\":15.142135623730951,\"categoryName\":3,\"name\":2.414213562373095,\"vname\":7},{\"tname\":9.660254037844386,\"sname\":18.32050807568877,\"categoryName\":4,\"name\":2.732050807568877,\"vname\":9},{\"tname\":11,\"sname\":21,\"categoryName\":5,\"name\":3,\"vname\":11},{\"tname\":12.180339887498949,\"sname\":23.360679774997898,\"categoryName\":6,\"name\":3.23606797749979,\"vname\":13},{\"tname\":13.24744871391589,\"sname\":25.49489742783178,\"categoryName\":7,\"name\":3.449489742783178,\"vname\":14},{\"tname\":14.228756555322953,\"sname\":27.457513110645905,\"categoryName\":8,\"name\":3.6457513110645907, \"vname\":16}]";
    NSMutableArray * dataProvider = [json objectFromJSONString];
   
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    ChartBase * chart = [ChartFactory getChart:chartType context:context];
    chart.dataProvider = dataProvider;
    chartView = [[ChartView alloc] initWithFrame:CGRectMake(12, 70, self.view.frame.size.width, self.view.frame.size.height - 70)];
    chartView.chart = chart;
    [self.view addSubview:chartView];
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn setFrame:CGRectMake(10, 5, 70, 40)];
    [backBtn addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    
    
    UIButton * zoomOutBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [zoomOutBtn setTitle:@"放大" forState:UIControlStateNormal];
    zoomOutBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [zoomOutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [zoomOutBtn setFrame:CGRectMake(85, 5, 70, 40)];
    [zoomOutBtn addTarget:self action:@selector(zoomOutHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zoomOutBtn];
    
    
    UIButton * zoomInBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [zoomInBtn setTitle:@"缩小" forState:UIControlStateNormal];
    zoomInBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [zoomInBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [zoomInBtn setFrame:CGRectMake(160, 5, 70, 40)];
    [zoomInBtn addTarget:self action:@selector(zoomInHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zoomInBtn];
    
    UIButton * dataBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [dataBtn setTitle:@"数据更新" forState:UIControlStateNormal];
    dataBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [dataBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dataBtn setFrame:CGRectMake(240, 5, 70, 40)];
    [dataBtn addTarget:self action:@selector(changeData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dataBtn];
	
}

- (void)returnBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) zoomOutHandler
{
    scale += 0.2;
    if (scale > 1.5)
    {
        scale = 1.5;
    }
    chartView.transform = CGAffineTransformMakeScale(scale, scale);
    
}

- (void) zoomInHandler
{
    scale -= 0.2;
    if (scale < 0.5)
    {
        scale = 0.5;
    }
    chartView.transform = CGAffineTransformMakeScale(scale, scale);
}



- (NSMutableArray *) getDataProvider
{
    if (dataChanged)
    {
        NSString * json = @"[{\"tname\":3,\"sname\":3,\"categoryName\":1,\"name\":1,\"vname\":3},{\"tname\":6,\"sname\":11,\"categoryName\":2,\"name\":3, \"vname\":5},{\"tname\":8.071067811865476,\"sname\":15.142135623730951,\"categoryName\":3,\"name\":2.414213562373095,\"vname\":7},{\"tname\":7.660254037844386,\"sname\":14.32050807568877,\"categoryName\":4,\"name\":3.732050807568877,\"vname\":9},{\"tname\":14,\"sname\":24,\"categoryName\":5,\"name\":3,\"vname\":11},{\"tname\":14.180339887498949,\"sname\":25.360679774997898,\"categoryName\":6,\"name\":3.23606797749979,\"vname\":13},{\"tname\":15.24744871391589,\"sname\":27.49489742783178,\"categoryName\":7,\"name\":7.449489742783178,\"vname\":14},{\"tname\":17.228756555322953,\"sname\":29.457513110645905,\"categoryName\":8,\"name\":6.6457513110645907, \"vname\":20}]";
        dataChanged = NO;
        return  [json objectFromJSONString];
    }
    dataChanged = YES;
     NSString * jsons = @"[{\"tname\":2,\"sname\":2,\"categoryName\":1,\"name\":1,\"vname\":3},{\"tname\":6,\"sname\":11,\"categoryName\":2,\"name\":2, \"vname\":5},{\"tname\":8.071067811865476,\"sname\":15.142135623730951,\"categoryName\":3,\"name\":2.414213562373095,\"vname\":7},{\"tname\":9.660254037844386,\"sname\":18.32050807568877,\"categoryName\":4,\"name\":2.732050807568877,\"vname\":9},{\"tname\":11,\"sname\":21,\"categoryName\":5,\"name\":3,\"vname\":11},{\"tname\":12.180339887498949,\"sname\":23.360679774997898,\"categoryName\":6,\"name\":3.23606797749979,\"vname\":13},{\"tname\":13.24744871391589,\"sname\":25.49489742783178,\"categoryName\":7,\"name\":3.449489742783178,\"vname\":14},{\"tname\":14.228756555322953,\"sname\":27.457513110645905,\"categoryName\":8,\"name\":3.6457513110645907, \"vname\":16}]";
    return  [jsons objectFromJSONString];
}


- (void) changeData
{
    if ([chartView.chart isKindOfClass:[DialChart class]])
    {
        
        dialValue = fisrtCircle ? dialValue - 10 : dialValue + 10;
        if (dialValue == 100)
        {
            fisrtCircle = true;
        }
        if (dialValue == 0)
        {
            fisrtCircle = false;
        }
        DialChart * dialChart = (DialChart *) chartView.chart;
        [dialChart setDialValueHandler:dialValue];
        return;
    }
    [chartView.chart setDataProviderHandler:[self getDataProvider]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
