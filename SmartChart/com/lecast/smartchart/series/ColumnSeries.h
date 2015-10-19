//
//  ColumnSeries.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "CartesianSeries.h"

@interface ColumnSeries : CartesianSeries
{
    CGFloat barSpaceWidth;
}
@property (nonatomic) CGFloat barSpaceWith;

- (id) init : (UIColor *) mColor;
- (void) drawColumnHandler : (UIView *)view;
- (void) addClickPoint : (int) index rect : (CGRect)mRect;
@end
