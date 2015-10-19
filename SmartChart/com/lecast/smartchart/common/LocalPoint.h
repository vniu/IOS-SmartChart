//
//  LocalPoint.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LocalPoint : NSObject
{
    CGFloat x;
    CGFloat y;
    NSObject * value;
    CGRect rect;
    NSString * valueField;
}
@property(nonatomic) CGFloat x;
@property(nonatomic) CGFloat y;
@property(nonatomic) CGRect rect;
@property(retain, nonatomic) NSObject * value;
@property (nonatomic, retain) NSString * valueField;
@end
