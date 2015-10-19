//
//  CircleLegend.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "CircleLegend.h"
#import "Series.h"
#import "Circle.h"
@implementation CircleLegend

- (void) drawLegendHandler:(CGContextRef)context displayName:(NSString *)name
{
    [self drawCircleHandler : context];
    [super drawLegendHandler:context displayName:name];
}

- (void) drawCircleHandler : (CGContextRef) context
{
    Circle * circle = [[Circle alloc] init:CGPointMake(x, y) radius:size];
    circle.fillColor = legendColor;
    circle.strokeColor = legendColor;
    [circle drawHandler:context];
}

@end
