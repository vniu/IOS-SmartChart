//
//  ChartParser.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-7-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChartModel.h"
@interface ChartParser : NSObject
{
    NSString * chartJson;
}
- (ChartModel *) parserHandler;
- (id) init : (NSString * ) mChartJson;
@end
