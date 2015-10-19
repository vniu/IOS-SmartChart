//
//  ReflectUtils.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "ReflectUtils.h"
#import <objc/runtime.h>
@implementation ReflectUtils

+ (NSString *) getStringValue : (NSObject *)object property : (NSString *) property
{
    if ([object isKindOfClass:[NSMutableDictionary class]])
    {
        NSMutableDictionary * dict = (NSMutableDictionary *)object;
        id value = [dict objectForKey:property] ;
        if (value  != nil && [value isKindOfClass:[NSString class]])
        {
            return (NSString *)value;
        }
        else if  (value  != nil && ![value isKindOfClass:[NSString class]])
        {
            return [value stringValue];
        }
        return @"";
    }
    return [[object valueForKey:property] stringValue];
}

+ (int) getIntValue : (NSObject *)object property : (NSString *) property
{
    if ([object isKindOfClass:[NSMutableDictionary class]])
    {
        NSMutableDictionary * dict = (NSMutableDictionary *)object;
        return [dict objectForKey:property] != nil ? [[dict objectForKey:property] intValue] : 0;
    }
    return [[object valueForKey:property] intValue];
}


+ (NSString *) getObjectValue : (NSObject *)object property : (NSString *) property
{
    if ([object isKindOfClass:[NSMutableDictionary class]])
    {
        NSMutableDictionary * dict = (NSMutableDictionary *)object;
        return [dict objectForKey:property];
    }
    return [object valueForKey:property];
}

@end
