//
//  AxisBase.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AxisLabelSetting.h"

@interface AxisBase : NSObject
{
    NSString * displayName;
    NSString * title;
    NSMutableArray * dataProvider;
    NSString * suffixName;
    bool isJsonFormat;
    AxisLabelSetting * axisLabelSetting;
    NSMutableArray * axisLabels;
    int itemCount;
    int padding;
    int fontSize;
    int textAngle;
    bool baseZero;
    int titleAngle;
}
@property (nonatomic, retain) NSString * displayName;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSMutableArray * dataProvider;
@property (nonatomic, retain) NSString * suffixName;
@property (nonatomic, retain) NSMutableArray * axisLabels;
@property (nonatomic, retain) AxisLabelSetting * axisLabelSetting;
@property (nonatomic) bool isJsonFormat;
@property (nonatomic) int itemCount;
@property (nonatomic) int padding;
@property (nonatomic) int fontSize;
@property (nonatomic) int textAngle;
@property (nonatomic) bool baseZero;
@property (nonatomic) int titleAngle;

- (void) setDataProviderHandler : (NSMutableArray *)dataSource;
- (void) updateHandler;
@end
