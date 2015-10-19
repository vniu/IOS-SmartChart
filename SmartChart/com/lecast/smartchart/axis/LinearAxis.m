//
//  LinearAxis.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "LinearAxis.h"
#import "AxisLabel.h"
#import "ReflectUtils.h"
#define NULL_VALUE  1.7976931348623157E308;
@implementation LinearAxis
@synthesize valueFields;
@synthesize interval;
@synthesize maxAxisValue;
- (id) init
{
    self = [super init];
    if (self)
    {
        minAxisValue = NULL_VALUE;
        maxAxisValue = - NULL_VALUE;
        interval = 1;
        titleAngle = 90;
        
    }
    return self;
}

- (void) updateHandler
{
    if (valueFields == nil)
    {
        return;
    }
    [self resetInitValue];
    [self onDataProviderHandler];
    [self initRange];
    [self generateLabels];
}


- (void) resetInitValue
{
    minAxisValue = NULL_VALUE;
    maxAxisValue = - NULL_VALUE;
    offset = 0;
    [axisLabels removeAllObjects];
}

- (void) generateLabels
{
    
    if (maxAxisValue < interval)
    {
        interval = maxAxisValue / 2;
    }
    double r = maxAxisValue - minAxisValue;
    double labelBase = labelMiniumn - floor((labelMiniumn - minAxisValue)/interval)*interval;
    if (alignLabelsToInterval)
    {
        labelBase = ceil(labelBase / interval) * interval;
    }
    double labelTop = maxAxisValue;
    int i = 0;
    double precision = 0;
    double decimal = abs(interval) - floor(abs(interval));
    precision = decimal == 0 ? 1 : -floor(log(decimal) / log(10));
    decimal = abs(minAxisValue) - floor(abs(minAxisValue));
    precision = MAX(precision, decimal == 0 ? 1 : -floor(log(decimal) / log(10)));
    double roundBase = pow(10, precision);
    double roundedValue = 0.0;
    for (i = (int) labelBase; i <= labelTop; i += interval)
    {
        roundedValue = round(i * roundBase) / roundBase;
        AxisLabel * axisLabel = [[AxisLabel alloc] init:(i - minAxisValue) / r value: [NSString stringWithFormat:@"%0.0f",roundedValue] text:[NSString stringWithFormat:@"%0.0f",roundedValue]];
        [axisLabels addObject:axisLabel];
    }
    axisLabelSetting.labels = axisLabels;
}

- (void) updateRange  : (double) y
{
    minAxisValue = MIN(minAxisValue, y);
    maxAxisValue = MAX(maxAxisValue, y);
}

- (void) initRange
{
    for (int index = 0; index < describeData.count; index++)
    {
        double y = [[describeData objectAtIndex:index] doubleValue];
        [self updateRange:y];
    }
    if (baseZero)
    {
        minAxisValue = 0;
    }
}
- (void) onDataProviderHandler
{
    itemCount = dataProvider.count;
    describeData = [[NSMutableArray alloc] init];
    int valueFieldSize = valueFields.count;
    for (int index = 0; index < itemCount; index++)
    {
        NSObject * object = [dataProvider objectAtIndex:index];
        for (int i = 0 ; i < valueFieldSize; i++)
        {
            NSObject * value = [ReflectUtils getStringValue:object property:[valueFields objectAtIndex:i]];
            [describeData addObject: value];
        }
    }
}

@end
