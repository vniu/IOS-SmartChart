//
//  SquareLegend.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "SquareLegend.h"
#import "Column.h"
@implementation SquareLegend


- (void) drawLegendHandler:(CGContextRef)context displayName:(NSString *)name
{
    [self drawSquareLegend : context];
    [super drawLegendHandler:context displayName:name];
}

- (void) drawSquareLegend : (CGContextRef) context
{
    Column * column = [[Column alloc] init:CGRectMake(x, y - 2, 10, 10)];
    column.fillColor = legendColor;
    column.strokeColor = legendColor;
    [column drawHandler:context];
}


@end
