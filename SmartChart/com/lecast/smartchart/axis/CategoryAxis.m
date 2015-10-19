//
//  CategoryAxis.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "CategoryAxis.h"
#import "AxisLabel.h"
#import "ReflectUtils.h"
@implementation CategoryAxis
@synthesize categoryField;
- (id) init
{
    self = [super init];
    if(self)
    {
        baseZero = NO;
        padding = 1.5;
    }
    return self;
}

- (void) updateHandler
{
    if (categoryField == nil)
    {
        return;
    }
    NSString * suffixStr = suffixName == nil ? @"" : suffixName;
    [self onDataProviderHandler:suffixStr];
}

- (void) onDataProviderHandler : (NSString *)suffixStr
{
    [axisLabels removeAllObjects];
    itemCount = dataProvider.count;
    double min = baseZero ? 0: -padding;
    double max = itemCount -1 + padding;
    double alen = max - min;
    for (int index = 0; index < itemCount; index++)
    {
        NSObject * object = [dataProvider objectAtIndex:index];
        NSString * value = [ReflectUtils getStringValue:object property:categoryField];
        AxisLabel * axisLabel = [[AxisLabel alloc] init:(index - min) /alen value:value text:[value stringByAppendingString:suffixStr]];
        [axisLabels addObject:axisLabel];
    }
    axisLabelSetting.labels = axisLabels;
}

@end
