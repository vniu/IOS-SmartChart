//
//  ChartCreator.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-7-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChartBase.h"
#import "ChartModel.h"
@interface ChartCreator : NSObject

+ (ChartBase *) getChart : (ChartModel * ) chartModel context : (CGContextRef) mContext;
+ (void) composeChartHandler : (ChartBase *) chart chartModel : (ChartModel *) chartModel context : (CGContextRef) mContext;
+ (ChartBase *) createChart : (ChartModel *) chartModel context : (CGContextRef) mContext;
@end
