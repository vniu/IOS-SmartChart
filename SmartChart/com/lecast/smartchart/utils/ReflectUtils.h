//
//  ReflectUtils.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReflectUtils : NSObject
+ (NSString *) getObjectValue : (NSObject *)object property : (NSString *) property;
+ (NSString *) getStringValue : (NSObject *)object property : (NSString *) property;
+ (int) getIntValue : (NSObject *)object property : (NSString *) property;
@end
