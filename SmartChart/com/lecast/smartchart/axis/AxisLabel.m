//
//  AxisLabel.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "AxisLabel.h"

@implementation AxisLabel
@synthesize position;
@synthesize value;
@synthesize text;
- (id)init : (double)index value : (NSObject *)valueObj text : (NSString *)textStr
{
    self = [super init];
    if(self)
    {
        position = index;
        value = valueObj;
        text = textStr;
    }
    return  self;
}


@end
