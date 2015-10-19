//
//  AxisCreator.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-7-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "AxisCreator.h"
#import "ChartConstants.h"
#import "CategoryAxis.h"
#import "LinearAxis.h"
#import "DialAxis.h"

@implementation AxisCreator

+ (AxisBase *) getAxis : (AxisModel *)model
{
    if ([model.name isEqualToString:kCategoryAxis])
    {
        CategoryAxis * categoryAxis = [[CategoryAxis alloc] init];
        categoryAxis.categoryField = model.categoryField;
        categoryAxis.displayName = model.displayName;
        categoryAxis.textAngle = model.textAngle;
        categoryAxis.suffixName = model.suffixName;
        return categoryAxis;
    }
    else if ([model.name isEqualToString:kLinearAxis])
    {
        LinearAxis * linearAxis = [[LinearAxis alloc] init];
        linearAxis.displayName = model.displayName;
        linearAxis.textAngle = model.textAngle;
        linearAxis.suffixName = model.suffixName;
        return linearAxis;
    }
    else if ([model.name isEqualToString:kDialAxis])
    {
        DialAxis * dialAxis = [[DialAxis alloc] init];
        dialAxis.maxValue = model.maxValue;
        dialAxis.minValue = model.minValue;
        return dialAxis;
    }
    return nil;
}

@end
