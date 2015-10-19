//
//  LineSeries.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-22.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "CartesianSeries.h"

@interface LineSeries : CartesianSeries

- (id) init : (UIColor *) mColor;

- (void) drawLineHandler : (UIView *)view;
@end
