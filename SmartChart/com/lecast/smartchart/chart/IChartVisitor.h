//
//  IChartVisitor.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-23.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColumnSeries.h"
@class LineSeries;

@protocol IChartVisitor <NSObject>
- (void) executeUpate : (LineSeries *) series;
//- (void) executeUpate : (ColumnSeries *) cseries;
@end
