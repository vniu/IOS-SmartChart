//
//  RoundChart.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "ChartBase.h"
#import "RoundSeries.h"
@interface RoundChart : ChartBase
{
    float centerX;
    float centerY;
    float radius;

}
@property(nonatomic)float centerX;
@property(nonatomic)float centerY;
@property(nonatomic)float radius;


- (void) commitedCenterPoint : (UIView *)view;
- (void) setSeriesProperty : (RoundSeries *)series;
- (id) init : (CGContextRef)context;
 //- (void) updatedCategoryAxis : (CategoryAxis*)axis
//{
//
//}
//- (void) updatedLinearAxis : (LinearAxis*)axis
//{
//
//}
@end
