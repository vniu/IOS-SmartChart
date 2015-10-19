//
//  RadarSeries.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-20.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "RoundSeries.h"

@interface RadarSeries : RoundSeries
{
    NSMutableArray * points;
    NSObject * data;
    CGFloat areaSize;
    BOOL isFill;
}
@property (nonatomic, retain) NSMutableArray * points;
@property (nonatomic, retain) NSObject * data;
@property (nonatomic) CGFloat areaSize;
@property (nonatomic) BOOL isFill;
- (id) init : (UIColor *) mColor;
@end
