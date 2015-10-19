//
//  DialAxis.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "AxisBase.h"
#import "Stroke.h"
@interface DialAxis : AxisBase
{
    CGFloat minValue;
    CGFloat maxValue;
    CGFloat minAngle;
    CGFloat maxAngle;
    double minorTick;
    double majorTick;
    CGFloat centerX;
    CGFloat centerY;
    CGFloat radius;
    int interval;
    int mutipleSpacer;
    NSMutableArray * colors;
    CGContextRef context;
    Stroke * stroke;
}
@property (nonatomic) CGFloat minValue;
@property (nonatomic) CGFloat maxValue;
@property (nonatomic) CGFloat minAngle;
@property (nonatomic) CGFloat maxAngle;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat radius;
@property (nonatomic) int interval;
@property (nonatomic) int mutipleSpacer;
@property (nonatomic, retain) NSMutableArray * colors;
@property (nonatomic, retain) Stroke * stroke;
- (void) drawAxisHandler : (CGContextRef) mContext;

- (void) drawTicks : (double)mLongRadius shortRadius : (double)mShortRadius tick : (double)mTick labels  :(BOOL)labels;
- (double) getAngleForValue : (double)value;

- (void) setCenterHandler : (CGFloat)mCenterX centerY : (CGFloat) mCenterY;

@end
