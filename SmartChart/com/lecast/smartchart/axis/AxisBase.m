//
//  AxisBase.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "AxisBase.h"
@implementation AxisBase

@synthesize displayName;
@synthesize title;
@synthesize dataProvider;
@synthesize suffixName;
@synthesize isJsonFormat;
@synthesize axisLabels;
@synthesize axisLabelSetting;
@synthesize itemCount;
@synthesize padding;
@synthesize fontSize;
@synthesize baseZero;
@synthesize textAngle;
@synthesize titleAngle;
- (id)init
{
    self = [super init];
    if (self)
    {
        isJsonFormat = false;
        itemCount = 0;
        padding = 1;
        fontSize = 12;
        baseZero = true;
        textAngle = -45;
        axisLabels = [[NSMutableArray alloc] init];
        axisLabelSetting = [[AxisLabelSetting alloc] init];
        titleAngle = 0;
    }
    return self;
}

- (void) setDataProviderHandler :(NSMutableArray *)dataSource
{
    if (dataSource == nil)
    {
        return;
    }
    dataProvider = dataSource;
    [self updateHandler];
   // [self update];
}


- (void) updateHandler
{
    
}

- (void) dataChanged
{
    
}



@end
