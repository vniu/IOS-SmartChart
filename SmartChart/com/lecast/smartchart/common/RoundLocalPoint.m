//
//  RoundLocalPoint.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "RoundLocalPoint.h"

@implementation RoundLocalPoint
@synthesize angle;

- (id) init : (float)drawAngle value : (NSObject *)valueObj
{
    self = [super init];
    if (self)
    {
        angle = drawAngle;
        value = valueObj;
    }
    return self;
}

@end
