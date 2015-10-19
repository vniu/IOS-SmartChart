//
//  RadarAxis.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-21.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "AxisBase.h"
#import "LinearAxis.h"
#import <CoreGraphics/CoreGraphics.h>

@interface RadarAxis : LinearAxis
{
    NSString * valueField;
    CGPoint startPoint;
    CGPoint endPoint;
    CGFloat angle;
    CGFloat length;
    CGContextRef context;
    CGFloat radius;
    CGFloat labelGap;
    CGFloat centerX;
    CGFloat centerY;
    CGFloat centerRadius;
    CGFloat tickLength;
    NSMutableArray * gridLinePoints;
    BOOL showLabel;
}

@property (nonatomic, retain) NSString * valueField;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) CGFloat angle;
@property (nonatomic) CGFloat length;
@property (nonatomic) CGContextRef context;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat labelGap;
@property (nonatomic) CGFloat radius;

- (id) init : (NSString *) fieldName;
- (void) drawAxisLine;

- (void) drawAxisMarkHandler;

@end
