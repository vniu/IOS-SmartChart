//
//  AnimColumnSeries.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-23.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "AnimColumnSeries.h"
#import "RectLayer.h"
#import "AxisLabel.h"
#import "SCGradientLayer.h"
#import "CALayer+Additions.h"
@implementation AnimColumnSeries

@synthesize enableGradient;

- (void) drawColumnHandler : (UIView *)view
{
    isVerticalGradient = NO;
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
            //[obj removeFromSuperlayer];
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
    CGFloat perUnitWidth = position * areaRectWidth;
    CGFloat bottom = view.frame.size.height - paddingBottom;
    CGFloat areaRectHeight = bottom - paddingTop;
    CGFloat totalSpaceWidth = 2 * barSpaceWidth;
    CGFloat perColumnWidth = (perUnitWidth - totalSpaceWidth) / seriesSize;
    CGFloat left, top, right;
    for (int index = 0; index < size; index++)
    {
        float value = [[propertyValues objectAtIndex:index] floatValue];
        AxisLabel * axisLabel = [axisLables objectAtIndex:index];
        stopX = axisLabel.position * areaRectWidth + paddingLeft;
        stopY = bottom -   value * (areaRectHeight/linearAxis.maxAxisValue);
        left = barSpaceWidth * (2 * index + 1) + (seriesIndex + seriesSize * index) * perColumnWidth + paddingLeft;// +
        right = left + perColumnWidth;
        top = stopY;
        float  height = bottom - top;
        id<ICALayer>  layer = [self createLayer:index value:value layersToRemove:layersToRemove];
        if (enableGradient)
        {
            [layer setFrameHandler:CGRectMake(left, bottom, perColumnWidth, 0)];
        }
        [layer setPropertyHandler:left height:height rectWidth:perColumnWidth bottom:bottom];
        [layer setValueHandler:value];
        [layer createAnimationForKey:@"startValue"
                              fromValue:[NSNumber numberWithDouble:bottom]
                                toValue:[NSNumber numberWithDouble:top]
                               delegate:self];
        [self addClickPoint:index rect:CGRectMake(left, top, perColumnWidth, bottom - top)];
    }
   [CATransaction commit];
}

- (id<ICALayer>)createLayer : (int) index value : (CGFloat) value  layersToRemove : (NSMutableArray *)layersToRemove
{
    CALayer * parentLayer = [chartView layer];
    id<ICALayer> layer;
    if( index >= [localLayers count] )
    {
        layer = enableGradient? [[SCGradientLayer alloc] init : stroke.strokeColor] : [RectLayer createRectLayer : stroke.strokeColor];
        if (enableGradient && !isVerticalGradient)
        {
            CAGradientLayer * gradientLayer = (SCGradientLayer *)layer;
            gradientLayer.startPoint = CGPointMake(0, 0.5);
            gradientLayer.endPoint = CGPointMake(1.0, 0.5);
        }
        //[parentLayer insertSublayer:(CALayer *)layer atIndex:0];
        [parentLayer addSublayer:(CALayer *)layer];
        [layer setSeriesIndex:seriesIndex];
        diff--;
    }
    else
    {
        id<ICALayer> onelayer = [localLayers objectAtIndex:index];
        if (diff > 0)
        {
            layer = onelayer;
            [parentLayer insertSublayer:(CALayer *)onelayer atIndex:index];
            diff--;
        }
        else if(diff < 0)
        {
            while(diff < 0)
            {
                [(CALayer *)onelayer removeFromSuperlayer];
                [parentLayer addSublayer:(CALayer *)onelayer];
                diff++;
                onelayer = [localLayers objectAtIndex:index];
                if([onelayer getValueHandler] == value || diff == 0)
                {
                    layer = onelayer;
                    [layersToRemove removeObject:layer];
                    break;
                }
            }
        }
    }
    return layer;
}



- (void) updateShapeHandler : (NSTimer *)timer
{
    NSLog(@"updateColumnHandler------%@",@"updateColumnHandler");
    
    if (enableGradient)
    {
        [self updateGradientRectHandler];
        return;
    }
    [self updateNoGradientRectHandler];
}

- (void) updateNoGradientRectHandler 
{
    [self getLayerByIndex];
    [localLayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         CGFloat startValue = [[[obj presentationLayer] valueForKey:@"startValue"] floatValue];
         RectLayer * rectLayer = (RectLayer *)obj;
         CGRect rect = CGRectMake(rectLayer.left, startValue, rectLayer.rectWidth ,rectLayer.bottom-startValue);
         [rectLayer drawPath:rect];
         [obj sendSublayerToBack];
     }];
}

- (void) updateGradientRectHandler 
{
    [self getLayerByIndex];
    [localLayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         SCGradientLayer * gradientLayer = (SCGradientLayer *)obj;
         CGFloat startValue = [[[gradientLayer presentationLayer] valueForKey:@"startValue"] floatValue];
         CGRect rect = CGRectMake(gradientLayer.left, startValue, gradientLayer.rectWidth ,gradientLayer.bottom - startValue);
         gradientLayer.frame = rect;
         if (idx == 0)
         {
             NSLog(@"updateGradientRectHandler＋＋＋＋%f", startValue);
         }
         [obj sendSublayerToBack];
     }];
}

- (void) getLayerByIndex
{
    localLayers = [[NSMutableArray alloc] init];
    CALayer * parentLayer = chartView.layer;
    NSArray * childrens = [parentLayer sublayers];
    for (id<ICALayer> layer in childrens)
    {
        if (([layer isKindOfClass:[SCGradientLayer class]] || [layer isKindOfClass:[RectLayer class]]) && [layer getSeriesIndex] == seriesIndex)
        {
            [localLayers addObject:layer];
        }
    }
}

@end
