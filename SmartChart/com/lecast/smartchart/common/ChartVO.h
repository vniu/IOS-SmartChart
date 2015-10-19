//
//  ChartVO.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-9.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChartVO : NSObject
{
    NSString * chartType;
    NSString * chartName;
}
@property (nonatomic, retain) NSString * chartType;
@property (nonatomic, retain) NSString * chartName;
@end
