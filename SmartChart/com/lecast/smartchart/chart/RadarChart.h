//
//  RadarChart.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-20.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "RoundChart.h"
#import "RadarAxis.h"
#import "RadarSeries.h"

@interface RadarChart : RoundChart
{
    NSMutableArray * axes;
    CGFloat centerRadius;
    CGFloat labelGap;
    NSString * labelField;
}
@property (nonatomic, retain) NSString * labelField;

- (void) commitProperties;
- (void) updateAxisHandler;
- (void) generateSeriesHandler;
- (void) addAxis : (RadarAxis *) axis;
- (void) setupAxisForDrawing : (RadarAxis *) axis angle : (CGFloat) angle;
- (void) generateRadarPoints;
@end
