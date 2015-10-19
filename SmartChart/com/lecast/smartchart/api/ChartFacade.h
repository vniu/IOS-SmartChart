//
//  ChartFacade.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-7-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChartView.h"
#import "ChartBase.h"

@interface ChartFacade : NSObject
{
    CGContextRef context;
    ChartView * chartView;
    ChartBase * chart;
}

- (id) init : (CGContextRef) context;
- (ChartView *) createChart : (NSString *) chartJson frame : (CGRect) frame;
- (void) refreshDataProvier : (NSObject *) dataProvider;

@end
