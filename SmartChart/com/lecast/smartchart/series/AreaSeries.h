//
//  AreaSeries.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "CartesianSeries.h"
#import "AreaShapeLayer.h"
@interface AreaSeries : CartesianSeries
{
    CGFloat timeCount;
    NSMutableArray * points;
    AreaShapeLayer * areaLayer;
    CGFloat bottom;
}
- (id) init : (UIColor *) mColor;
- (void) drawHighLightPoint : (NSMutableArray *) circlePoints fillColor : (UIColor *) fillColor;
@end
