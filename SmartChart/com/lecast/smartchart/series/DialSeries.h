//
//  DialSeries.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-5.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "RoundSeries.h"

@interface DialSeries : RoundSeries
{
    CGFloat currtValue;
    CGFloat minValue;
    CGFloat maxValue;
    BOOL  isRotate;
    CGFloat rotateValue;
    CGFloat endAngle;
    CGFloat minAngle;
    CGFloat maxAngle;
    CGFloat angleSpacer;
}

@property (nonatomic)  CGFloat currtValue;

- (void) setAngleRangle : (CGFloat)mMinAngle maxAngle : (CGFloat) mMaxAngle;
- (void) setValueRangle : (CGFloat)mMinValue maxAngle : (CGFloat) mMaxValue;
@end
