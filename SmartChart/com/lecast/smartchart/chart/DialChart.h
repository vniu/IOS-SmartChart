//
//  DialChart.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "RoundChart.h"
#import "DialAxis.h"
@interface DialChart : RoundChart
{
    DialAxis * dialAxis;
    CGFloat dialValue;
}

@property (nonatomic, retain) DialAxis * dialAxis;

- (void) setDialValueHandler:(CGFloat)value;

- (void) drawAxis;

- (id) init : (CGContextRef)mContext dialAxis : (DialAxis *) mDialAxis;
@end
