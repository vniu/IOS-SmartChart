//
//  DiamondLegend.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "DiamondLegend.h"
#import "Diamon.h"
@implementation DiamondLegend

- (void) drawLegendHandler:(CGContextRef)context displayName:(NSString *)name
{
    [self drawDiamondLegend : context];
    [super drawLegendHandler:context displayName:name];
}


- (void) drawDiamondLegend : (CGContextRef) context
{
    Diamon * diamon = [[Diamon alloc] init];
    diamon.fillColor = legendColor;
    diamon.strokeColor = legendColor;
    [diamon drawDiamonHandler:CGPointMake(x, y)];
    [diamon  drawHandler:context];
}

@end
