//
//  AxisModel.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-7-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@interface AxisModel : NSObject
{
    NSString * name;
    NSString  * displayName;
    NSString * valueField;
    NSString * categoryField;
    NSInteger interval;
    NSInteger textAngle;
    NSString * suffixName;
    CGFloat maxValue;
    CGFloat minValue;
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * displayName;
@property (nonatomic, retain) NSString * valueField;
@property (nonatomic, retain) NSString * categoryField;
@property (nonatomic) NSInteger interval;
@property (nonatomic) NSInteger textAngle;
@property (nonatomic, retain) NSString * suffixName;
@property (nonatomic) CGFloat maxValue;
@property (nonatomic) CGFloat minValue;

@end
