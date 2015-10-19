//
//  TriangleLegend.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "TriangleLegend.h"
#import "Triangle.h"
@implementation TriangleLegend


- (void) drawLegendHandler:(CGContextRef)context displayName:(NSString *)name
{
    [self drawTriangleLegend : context];
    [super drawLegendHandler:context displayName:name];
}

- (void) drawTriangleLegend : (CGContextRef) context
{
    Triangle * triangle = [[Triangle alloc] init];
    triangle.fillColor = legendColor;
    triangle.strokeColor = legendColor;
    [triangle drawTriangleHandler:CGPointMake(x, y + 7.5)];
    [triangle  drawHandler:context];
}


@end
