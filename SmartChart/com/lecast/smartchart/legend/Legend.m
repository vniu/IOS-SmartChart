//
//  Legend.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Legend.h"
#import "DrawUtils.h"
#import "PieSeries.h"
#import "ChartBase.h"

@implementation Legend
@synthesize size;
@synthesize fontSize;
@synthesize chart;
@synthesize x;
@synthesize y;

@synthesize view;
- (id) init
{
    self = [super init];
    if (self)
    {
        x = 10;
        y = 10;
        size = 8;
    }
    return self;
}

- (BOOL) drawPieLegend : (CGContextRef) context series : (Series *) series
{
    if ([series isKindOfClass:[PieSeries class]])
    {
        y = y - 40; // For paddingBottom distance
        PieSeries * pieSeries = (PieSeries *) series;
        NSMutableArray *  colors = [pieSeries getCacheColors];
        int count = 0;
        for (UIColor * color in colors)
        {
            legendColor = color;
            [self drawLegendHandler:context displayName:[pieSeries.labels objectAtIndex:count]];
            count ++;
        }
        return true;
    }
    return false;
}

- (void) executeDrawHandler : (CGContextRef) context
{
    for(Series * series in chart.mSeries)
    {
        if ([self drawPieLegend:context series:series])
        {
            return;
        }
        legendColor = series.stroke.strokeColor;
        [self drawLegendHandler:context displayName:series.displayName];
    }
}

- (void) drawLegendHandler : (CGContextRef) context displayName : (NSString *) name
{
    CGSize rectSize = [DrawUtils getTextRect:name fontSize:fontSize];
    [name drawAtPoint:CGPointMake(x + 2 * size, y - rectSize.height/2) withFont:[UIFont systemFontOfSize:fontSize]];
    x = x + size + (name == nil ? 10 : rectSize.width + 10 + size);
    if (x > view.frame.size.width)
        y += 20;
}

@end
