//
//  AnimLineSeries.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-23.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "LineSeries.h"

@interface AnimLineSeries : LineSeries
{
    NSMutableArray * localLayers;
    NSInteger diff;
    NSMutableArray * points;
}
@end
