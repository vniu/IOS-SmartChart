//
//  RoundSeries.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "RoundSeries.h"
#import "DrawUtils.h"
#import "RoundPointMapping.h"
#import "RoundLocalPoint.h"
#import "ReflectUtils.h"
@implementation RoundSeries
@synthesize radius;
@synthesize labelField;
@synthesize showLabel;
@synthesize suffixName;
- (id) init
{
    self = [super init];
    if (self)
    {
        colorsCache = [[NSMutableArray alloc] init];
        labelColor = [UIColor blackColor];
        showLabel = YES;
    }
    return  self;
}

- (NSMutableArray *) getCacheColors
{
    return colorsCache;
}

- (void) onDrawHandler : (UIView*)view
{
    [colorsCache removeAllObjects];
    [self generateColors];
}

- (void) generateColors
{
    for (int index = 0; index < dataSize; index++)
    {
        [colorsCache addObject:[DrawUtils getRandomColor]];
    }
}

- (NSString *) getCategoryName : (int) index
{
    suffixName = suffixName == nil ? @"" : suffixName;
    NSObject * object = [dataProvider objectAtIndex:index];
    NSString * value = [ReflectUtils getObjectValue:object property:labelField];
    return [NSString stringWithFormat:@"%@%@", value, suffixName];
}

- (void) setCenterHandler : (float)mLastCenterX lastCenterY : (float)mLastCenterY  lastRadius : (float)mLastRadius
{
    RoundPointMapping *roundPointMapping = (RoundPointMapping *)pointMapping;
    [roundPointMapping setCenterHandler:mLastCenterX centerY:mLastCenterY];
    roundPointMapping.radius = mLastRadius;
    centerX = mLastCenterX;
    centerY = mLastCenterY;
}

- (void) addClickPoint : (int)index angle : (float)angle;
{
    NSObject * object = [dataProvider objectAtIndex:index];
    RoundPointMapping *roundPointMapping = (RoundPointMapping *)pointMapping;
    RoundLocalPoint * touchPoint = [[RoundLocalPoint alloc] init:angle value:object];
    [roundPointMapping addPoint:touchPoint];
}


@end
