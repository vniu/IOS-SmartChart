//
//  ChartViewViewController.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartView.h"
@interface ChartViewViewController : UIViewController
{
    NSString * chartType;
    CGFloat scale;
    ChartView * chartView;
    BOOL dataChanged;
    CGFloat dialValue;
    BOOL fisrtCircle;
    
}

@property (nonatomic, retain) NSString * chartType;
- (void)returnBack;
@end
