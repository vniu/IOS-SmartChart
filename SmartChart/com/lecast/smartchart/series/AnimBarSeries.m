//
//  AnimBarSeries.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-3.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "AnimBarSeries.h"
#import "AxisLabel.h"
#import <QuartzCore/QuartzCore.h>
#import "SCGradientLayer.h"
#import "RectLayer.h"

@implementation AnimBarSeries

- (void) drawColumnHandler : (UIView *)view
{
    isVerticalGradient = YES;
    enableGradient = YES;
    animations = [[NSMutableArray alloc] init];
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [view setUserInteractionEnabled:NO];
    __block NSMutableArray *layersToRemove = nil;
    [CATransaction setCompletionBlock:
     ^{
         [layersToRemove enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
          {
              [obj removeFromSuperlayer];
          }];
         [layersToRemove removeAllObjects];
         [view setUserInteractionEnabled:YES];
     }];
    [self getLayerByIndex];
    diff = dataSize - [localLayers count];
    layersToRemove = [NSMutableArray arrayWithArray:localLayers];
    
    CGFloat areaRectWidth = view.frame.size.width - paddingLeft - paddingRight;
    NSMutableArray * axisLables = categoryAxis.axisLabels;
    int size = axisLables.count;
    CGFloat stopX, stopY;
    AxisLabel * axisLabel = categoryAxis.baseZero ? [axisLables objectAtIndex:1]: [axisLables objectAtIndex:0];
    CGFloat position = axisLabel.position;
    CGFloat bottom = view.frame.size.height - paddingBottom;
    CGFloat areaRectHeight = bottom - paddingTop;
    CGFloat perUnitWidth = position * areaRectHeight;
    CGFloat totalSpaceWidth = 2 * barSpaceWidth;
    CGFloat perColumnWidth = (perUnitWidth - totalSpaceWidth) / seriesSize;
    CGFloat top, right, mBottom;
    paddingLeft = paddingLeft + 1;
    for (int index = 0; index < size; index++)
    {
        float value = [[propertyValues objectAtIndex:index] floatValue];
        AxisLabel * axisLabel = [axisLables objectAtIndex:index];
        CGFloat rectWidth = [[propertyValues objectAtIndex:index] floatValue] * (areaRectWidth/linearAxis.maxAxisValue) ;
        stopX = rectWidth + paddingLeft;
        stopY = bottom - axisLabel.position * areaRectHeight;
        mBottom = bottom - ((barSpaceWidth * (2 * index + 1) + (seriesIndex + seriesSize * index)
                             * perColumnWidth));
        top = mBottom - perColumnWidth;
        right = stopX;
        id<ICALayer>  layer = [self createLayer:index value:value layersToRemove:layersToRemove];
        if (enableGradient)
        {
            [layer setFrameHandler:CGRectMake(paddingLeft, top, 0, perColumnWidth)];
        }
        [layer setPropertyHandler:paddingLeft height:perColumnWidth rectWidth:rectWidth bottom:top];
        [layer setValueHandler:value];
        [layer createAnimationForKey:@"startValue"
                           fromValue:[NSNumber numberWithDouble:0]
                             toValue:[NSNumber numberWithDouble:rectWidth]
                            delegate:self];
        [self addClickPoint:index rect:CGRectMake(paddingLeft, top, rectWidth, perColumnWidth)];
    }
    [CATransaction commit];
}

- (void) updateNoGradientRectHandler
{
    [self getLayerByIndex];
    [localLayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         CGFloat startValue = [[[obj presentationLayer] valueForKey:@"startValue"] floatValue];
         RectLayer * rectLayer = (RectLayer *)obj;
         CGRect rect = CGRectMake(rectLayer.left, rectLayer.bottom,  startValue, rectLayer.height);
         [rectLayer drawPath:rect];
     }];
}

- (void) updateGradientRectHandler
{
    [self getLayerByIndex];
    [localLayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         SCGradientLayer * gradientLayer = (SCGradientLayer *)obj;
         CGFloat startValue = [[[gradientLayer presentationLayer] valueForKey:@"startValue"] floatValue];
         CGRect rect = CGRectMake(gradientLayer.left, gradientLayer.bottom,  startValue, gradientLayer.height);
         gradientLayer.frame = rect;
         if (idx == 0)
         {
             NSLog(@"updateGradientRectHandler＋＋＋＋%f", startValue);
         }
    }];
}

@end
