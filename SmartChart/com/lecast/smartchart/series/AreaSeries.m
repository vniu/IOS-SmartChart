//
//  AreaSeries.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "AreaSeries.h"
#import "AxisLabel.h"
#import "Area.h"
#import "UIColor+ChartColor.h"
#import "Circle.h"
#import "AreaShapeLayer.h"
#import "AnimationUtils.h"

@implementation AreaSeries


- (id) init : (UIColor *) mColor
{
    self = [super init];
    if (self)
    {
        stroke = [[Stroke alloc] init:mColor fillColor:[mColor colorWithAlphaComponent:0.5]];
    }
    return self;
}


- (void) onDrawHandler : (UIView*)view
{
    [super onDrawHandler:view];
    [self drawLineHandler:view];
}

- (void) drawLineHandler : (UIView *)view
{
    int width = view.frame.size.width;
    int height = view.frame.size.height;
    int areaRectWidth = width - paddingLeft - paddingRight;
    float areaRectHeight = height - paddingBottom- paddingTop;
    bottom = height - paddingBottom;
    NSMutableArray * axisLabels = horizontalAxis.axisLabelSetting.labels;
    int size = axisLabels.count;
    float stopX = 0;
    float stopY = 0;
    Area * area = [[Area alloc] init];
    area.fillColor = stroke.fillColor;
    area.strokeColor = stroke.strokeColor;
    NSMutableArray * circlePoints = [[NSMutableArray alloc] init];
    for (int index = 0; index < size; index++)
    {
        AxisLabel * axisLabel = [axisLabels objectAtIndex:index];
        stopX = axisLabel.position * areaRectWidth + paddingLeft;
        stopY = bottom - [[propertyValues objectAtIndex:index] floatValue] * (areaRectHeight/linearAxis.maxAxisValue);
        if (index == 0)
        {
            [area moveToPoint:CGPointMake(stopX, bottom)];
        }
        [area addLineToPoint:CGPointMake(stopX, stopY)];
        if (index == size - 1)
        {
            [area addLineToPoint:CGPointMake(stopX, bottom)];
        }
        [circlePoints addObject:[NSValue valueWithCGPoint:CGPointMake(stopX, stopY)]];
        [self addClickPoint:index point:CGPointMake(stopX, stopY)];
    }
    [area drawHandler:context];
    [self drawHighLightPoint:circlePoints fillColor:area.strokeColor];
    
}


- (void) drawAreaLayerHandler : (UIView *)view
{
    points = [[NSMutableArray alloc]init];
    int width = view.frame.size.width;
    int height = view.frame.size.height;
    int areaRectWidth = width - paddingLeft - paddingRight;
    float areaRectHeight = height - paddingBottom- paddingTop;
    bottom = height - paddingBottom;
    NSMutableArray * axisLabels = horizontalAxis.axisLabelSetting.labels;
    int size = axisLabels.count;
    float stopX = 0;
    float stopY = 0;
    areaLayer = [[AreaShapeLayer alloc] init];
    UIColor * color = [UIColor randomColor];
    areaLayer.fillColor = [[color colorWithAlphaComponent:0.5] CGColor];
    areaLayer.strokeColor = [color CGColor];
    NSMutableArray * circlePoints = [[NSMutableArray alloc] init];
    CGFloat startValue;
    CGFloat endValue;
    CGMutablePathRef startPathRef = CGPathCreateMutable();
    for (int index = 0; index < size; index++)
    {
        AxisLabel * axisLabel = [axisLabels objectAtIndex:index];
        stopX = axisLabel.position * areaRectWidth + paddingLeft;
        stopY = bottom - [[propertyValues objectAtIndex:index] floatValue] * (areaRectHeight/linearAxis.maxAxisValue);
        if (index == 0)
        {
            startValue = stopX;
            [areaLayer moveToPoint:CGPointMake(stopX, bottom)];
            CGPathMoveToPoint(startPathRef, nil, stopX, bottom);
            CGPathAddLineToPoint(startPathRef, nil, stopX, stopY);
        }
        [areaLayer addLineToPoint:CGPointMake(stopX, stopY)];
        if (index == size - 1)
        {
            endValue = stopX;
            [areaLayer addLineToPoint:CGPointMake(stopX, bottom)];
        }
        [points addObject:[NSValue valueWithCGPoint:CGPointMake(stopX, stopY)]];
        [circlePoints addObject:[NSValue valueWithCGPoint:CGPointMake(stopX, stopY)]];
        [self addClickPoint:index point:CGPointMake(stopX, stopY)];
    }
    [view.layer addSublayer:areaLayer];
   
    [AnimationUtils addPathAnimation:areaLayer fromPath:startPathRef toPath:areaLayer.pathRef delegate:self];
//    CAKeyframeAnimation *penAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    penAnimation.duration = 10.0;
//    penAnimation.path = areaLayer.pathRef;
//    penAnimation.calculationMode = kCAAnimationPaced;
//    [areaLayer addAnimation:penAnimation forKey:@"penAnimation"];
    
    
//    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
//    pathAnimation.duration = 10.0;
//    
//   // pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAnimation.toValue = (id) areaLayer.fillColor;//[NSNumber numberWithFloat:1.0f];
//    [areaLayer addAnimation:pathAnimation forKey:@"fillColor"];
    
    //[self drawHighLightPoint:circlePoints fillColor:area.strokeColor];

    [areaLayer drawPath];
    
    [self drawHighLightPoint:points fillColor:[UIColor randomColor]];
    [self breathAnimation];
    
}

- (CAAnimation*)pathAnimation
{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    [animation setPath:areaLayer.pathRef];
    [animation setDuration:3.0];
    [animation setAutoreverses:YES];
    animation.calculationMode = kCAAnimationLinear;
    return animation;
}

- (void)resizeLayer:(CALayer*)layer
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    animation.fromValue = 0;
    animation.duration = 3;
    animation.toValue = [NSNumber numberWithFloat:200];
    animation.fillMode = kCAFillModeForwards;
    [layer addAnimation:animation forKey:@"bounds.size"];
}

- (void) drawHighLightPoint : (NSMutableArray *) circlePoints fillColor : (UIColor *) fillColor
{
    for (NSValue * value in circlePoints)
    {
        Circle * circlePoint = [[Circle alloc] init:value.CGPointValue radius : 4.0f];
        circlePoint.fillColor = fillColor;
        [circlePoint drawHandler:context];
    }
}


NSString* kAnimation = @"animation";
NSString* kBreath = @"breath";
NSString* kHide = @"hide";
NSString* kOpacity = @"opacity";

- (void) breathAnimation
{
    
    [CATransaction begin];
    
    CAKeyframeAnimation *darkblueBreathAnimation = [CAKeyframeAnimation animationWithKeyPath:kOpacity];
    
    NSArray *darkblueOpacityValues = [NSArray arrayWithObjects:[NSNumber numberWithFloat:1.0f],
                                      [NSNumber numberWithFloat:0.0f],
                                      [NSNumber numberWithFloat:1.0f],
                                      nil];
    
    NSArray *darkblueOpacityTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f],
                                     [NSNumber numberWithFloat:0.5f],
                                     [NSNumber numberWithFloat:1.0f],
                                     nil];
    
    [darkblueBreathAnimation setValues:darkblueOpacityValues];
    
    [darkblueBreathAnimation setKeyTimes:darkblueOpacityTimes];
    
    [darkblueBreathAnimation setDuration:1.0f];
    
    [darkblueBreathAnimation setRepeatCount:2];
    
    [darkblueBreathAnimation setFillMode:kCAFillModeRemoved];
    
    [darkblueBreathAnimation setCalculationMode:kCAAnimationLinear];
    
    [darkblueBreathAnimation setRemovedOnCompletion:YES];
    
    [darkblueBreathAnimation setDelegate:self];
    
    [areaLayer addAnimation:darkblueBreathAnimation forKey:kBreath];
    
    CAKeyframeAnimation *lightblueBreathAnimation = [CAKeyframeAnimation animationWithKeyPath:kOpacity];
    
    NSArray *lightblueOpacityValues = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f],
                                       [NSNumber numberWithFloat:1.0f],
                                       [NSNumber numberWithFloat:0.0f],
                                       nil];
    
    NSArray *lightblueOpacityTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f],
                                      [NSNumber numberWithFloat:0.5f],
                                      [NSNumber numberWithFloat:1.0f],
                                      nil];
    
    [lightblueBreathAnimation setValues:lightblueOpacityValues];
    
    [lightblueBreathAnimation setKeyTimes:lightblueOpacityTimes];
    
    [lightblueBreathAnimation setDuration:1.0f];
    
    [lightblueBreathAnimation setRepeatCount:2];
    
    [lightblueBreathAnimation setFillMode:kCAFillModeRemoved];
    
    [lightblueBreathAnimation setCalculationMode:kCAAnimationLinear];
    
    [lightblueBreathAnimation setRemovedOnCompletion:YES];
    
    [lightblueBreathAnimation setDelegate:self];
    
    [lightblueBreathAnimation setValue:kBreath forKey:kAnimation];
    
    [areaLayer addAnimation:lightblueBreathAnimation forKey:kBreath];
    
    [CATransaction commit];

}


@end
