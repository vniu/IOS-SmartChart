//
//  ChartLegendCreator.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-7-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Legend.h"
#import "ChartBase.h"
@interface ChartLegendCreator : NSObject

+ (Legend *) getLegend : (ChartBase *) chart legendName : (NSString *)legendName;
@end
