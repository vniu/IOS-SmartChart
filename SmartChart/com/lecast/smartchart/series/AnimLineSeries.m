//
//  AnimLineSeries.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-23.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "AnimLineSeries.h"
#import <QuartzCore/QuartzCore.h>
#import "LineLayer.h"
#import "AxisLabel.h"
#import "Circle.h"
#import "CircleLayer.h"
#import "CALayer+Additions.h"

@implementation AnimLineSeries

- (void) onDrawHandler : (UIView*) view
{
    [super onDrawHandler:view];
    [self drawLineHandler:view];
}

- (void) drawLineHandler : (UIView *)view
{
    animations = [[NSMutableArray alloc] init];
    points = [[NSMutableArray alloc] init];
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [view setUserInteractionEnabled:NO];
    __block NSMutableArray *layersToRemove = nil;
    [CATransaction setCompletionBlock:
     ^{
         [layersToRemove enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
          {
           //  [obj removeFromSuperlayer];
          }];
         [layersToRemove removeAllObjects];
         [view setUserInteractionEnabled:YES];
     }];
    [self getLayerByIndex];
    diff = dataSize - [localLayers count];
    layersToRemove = [NSMutableArray arrayWithArray:localLayers];
    int width = view.frame.size.width;
    int height = view.frame.size.height;
    int areaRectWidth = width - paddingLeft - paddingRight;
    float areaRectHeight = height - paddingBottom- paddingTop;
    float bottom = height - paddingBottom;
    NSMutableArray * axisLabels = horizontalAxis.axisLabelSetting.labels;
    int size = axisLabels.count;
    float startX = 0;
    float startY = 0;
    float stopX = 0;
    float stopY = 0;
    for (int index = 0; index < size; index++)
    {
        AxisLabel * axisLabel = [axisLabels objectAtIndex:index];
        stopX = axisLabel.position * areaRectWidth + paddingLeft;
        stopY = bottom - [[propertyValues objectAtIndex:index] floatValue] * (areaRectHeight/linearAxis.maxAxisValue);
        CGPoint startPoint = CGPointMake(startX, startY);
        CGPoint endPoint =  CGPointMake(stopX, stopY);
        CircleLayer * circleLayer = [CircleLayer createCircleLayer:stroke.strokeColor];
        [chartView.layer addSublayer:circleLayer];
        [circleLayer drawPath:endPoint radius:3.0f];
        if (index > 0)
        {
            LineLayer *layer = (LineLayer *)[self createLayer:(index-1) value:[[propertyValues objectAtIndex:(index-1)] floatValue] layersToRemove:layersToRemove];
            [layer createAnimationForKey:@"startValue" fromValue:[NSNumber numberWithFloat:startPoint.x] toValue:[NSNumber numberWithFloat:endPoint.x] delegate:self];
            [layer createAnimationForKey:@"endValue" fromValue:[NSNumber numberWithFloat:startPoint.y] toValue:[NSNumber numberWithFloat:endPoint.y] delegate:self];
            layer.startPoint = startPoint;
            layer.endPoint = endPoint;
        }
        startX = stopX;
        startY = stopY;
        [self addClickPoint:index point:CGPointMake(stopX, stopY)];
    }
    for (NSValue * value in points)
    {
        NSLog(@"------%@",@"update");
      
    }
    [CATransaction commit];
}

- (id<ICALayer>)createLayer : (int) index value : (CGFloat) value  layersToRemove : (NSMutableArray *)layersToRemove
{
    CALayer * parentLayer = [chartView layer];
    id<ICALayer> layer;
    if( index >= ([localLayers count]))
    {
        layer = [LineLayer createLineLayer:stroke.strokeColor];
        [layer setSeriesIndex:seriesIndex];
        [layer setValueHandler:value];
        [parentLayer addSublayer:(CALayer *)layer];
        //[parentLayer insertSublayer:(CALayer *)layer atIndex:0];
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
    [self updateLineHandler];
}


- (void) updateLineHandler
{
    [self getLayerByIndex];
     NSLog(@"updateLineHandler------%@",@"update");
    [localLayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         CGFloat startValue = [[[obj presentationLayer] valueForKey:@"startValue"] floatValue];
         CGFloat endValue = [[[obj presentationLayer] valueForKey:@"endValue"] floatValue];
         LineLayer * lineLayer = (LineLayer *)obj;
         [lineLayer drawPath:lineLayer.startPoint endPoint:CGPointMake(startValue, endValue)];
     }];
}



-(void) updateOnStopHandler
{
    
    [localLayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         
     }];
    for (NSValue * value in points)
    {
        NSLog(@"------%@",@"update");
//        Circle * circlePoint = [[Circle alloc] init:value.CGPointValue radius:5.0f];
//        circlePoint.fillColor = stroke.strokeColor;
//        [circlePoint drawHandler:context];
    }
   
}

- (void) getLayerByIndex
{
    localLayers = [[NSMutableArray alloc] init];
    CALayer * parentLayer = chartView.layer;
    NSArray * childrens = [parentLayer sublayers];
    for (id<ICALayer> layer in childrens)
    {
        if ([layer isKindOfClass:[LineLayer class]] && [layer getSeriesIndex] == seriesIndex)
        {
            [localLayers addObject:layer];
        }
    }
}

@end
