//
//  RoundChart.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "RoundChart.h"
#import "RoundPointMapping.h"
@implementation RoundChart

@synthesize centerX, centerY, radius;

-(id)init
{
    self = [super init];
    if (self)
    {
        pointMapping = [[RoundPointMapping alloc] init];
        radius = 100;
    }
    return self;
}


- (id) init : (CGContextRef)mContext
{
    self = [super init];
    if (self)
    {
        pointMapping = [[RoundPointMapping alloc] init];
        context = mContext;
        radius = 100;
    }
    return self;
}

- (void)onDraw:(UIView *)view
{
    [pointMapping clear];
    if (dataProvider != nil)
    {
        [self commitedCenterPoint:view];
        [self drawSeriesHandler:view];
    }
    [super onDraw:view];
    
}

- (void) commitedCenterPoint:(UIView *)view
{
    int width = view.frame.size.width;
    int height = view.frame.size.height;
    centerX = (width - paddingLeft - paddingRight) / 2 + paddingLeft;
    centerY = (height - paddingTop - paddingBottom) / 2 + paddingTop;
}

- (LocalPoint *) getPointForScreenCoordinate:(LocalPoint *)screenPoint
{
    RoundPointMapping * roundPointMapping = (RoundPointMapping *)pointMapping;
    return [roundPointMapping getClickPoint:screenPoint];
}

- (void) setSeriesProperty : (RoundSeries *)series
{
    series.pointMapping = pointMapping;
    [series setCenterHandler:centerX lastCenterY:centerY lastRadius:radius];
    [series setOffset:offsetX offsetY:offsetY];
    series.context = context;
    series.fontSize = fontSize;
    series.radius = radius;
    [series setDataProviderHandler:dataProvider];
}

@end
