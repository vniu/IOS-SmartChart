//
//  RadarAxis.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-21.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "RadarAxis.h"
#import "ReflectUtils.h"
#import "AxisLabel.h"
#import "Line.h"
#import "DrawUtils.h"
#import <GLKit/GLKit.h>
#import "NSString+NSChartLabelDraw.h"
@implementation RadarAxis

@synthesize valueField;
@synthesize startPoint;
@synthesize endPoint;
@synthesize angle;
@synthesize length;
@synthesize context;
@synthesize radius;
@synthesize centerX;
@synthesize centerY;
@synthesize labelGap;

- (id) init : (NSString *) fieldName
 {
    self = [super init];
    if (self)
    {
        valueField = fieldName;
        centerRadius = 0;
        tickLength = 5;
        gridLinePoints = [[NSMutableArray alloc] init];
        showLabel = YES;
    }
    return self;
}


- (void) updateHandler
{
    if (valueField == nil)
    {
        return;
    }
    [self resetInitValue];
    [self onDataProviderHandler];
    [self initRange];
    [self generateLabels];
}

- (void) resetInitValue
{
    [super resetInitValue];
    [gridLinePoints removeAllObjects];
}

- (void) onDataProviderHandler
{
    itemCount = dataProvider.count;
    describeData = [[NSMutableArray alloc] init];
    for (int index = 0; index < itemCount; index++)
    {
        NSObject * object = [dataProvider objectAtIndex:index];
        NSObject * value = [ReflectUtils getStringValue:object property:valueField];
        [describeData addObject: value];
    }
}

- (void) drawAxisLine
{
    Line * horLine = [[Line alloc] initWithPoint:startPoint endPoint:endPoint];
    horLine.strokeColor = [UIColor redColor];
    horLine.lineWidth = 1;
    [horLine drawHandler:context];
    [self positionTitleHandler];
}


- (void) positionTitleHandler
{
    UIFont * font = [UIFont systemFontOfSize:fontSize];
    CGSize size = [DrawUtils getTextRect:displayName fontSize:fontSize];
    if (showLabel)
    {
        CGFloat opposite = size.width / 2;
        CGFloat adjacent = radius + labelGap;
        CGFloat hypoenuse = sqrtf(powf(opposite, 2) + pow(adjacent, 2));
        CGFloat labelAngle = atan(opposite / adjacent);
        CGFloat rotation = GLKMathRadiansToDegrees(angle) + 90;
        CGFloat ta = rotation;
        if(ta < 0)
            ta += 360;
        if(ta > 135 && ta < 270)
        {
            rotation += 180;
            [displayName drawWithBasePoint:CGPointMake(centerX + cos(angle + labelAngle) * (hypoenuse + size.height/2),
                                                       centerY + sin(angle + labelAngle) * (hypoenuse + size.height/2)) andAngle:rotation andFont:font];
        }
        else
        {
            CGPoint labelPoint =  CGPointMake(centerX + cos(angle - labelAngle) * hypoenuse, centerY + sin(angle - labelAngle) * hypoenuse);
            [displayName drawWithBasePoint:labelPoint andAngle:rotation andFont:font];
        }
    }
    else
    {
        CGPoint drawPoint = CGPointMake(centerX + cos(angle) * (radius + labelGap - size.height),
                                        centerY + sin(angle) * (radius + labelGap - size.height));
        if(angle > M_PI_2 && angle < 1.5 * M_PI)
            drawPoint.x -= size.width;
        drawPoint.y -= size.height/2;
        [displayName drawWithBasePoint:drawPoint andAngle:0 andFont:font];
    }
}

- (void) drawAxisMarkHandler
{
    if (!showLabel)
    {
        return;
    }
    for (AxisLabel * label in axisLabels)
    {
        CGSize size = [DrawUtils getTextRect:label.text fontSize:fontSize];
        CGFloat opposite = size.width + centerRadius;
        CGFloat adjacent = label.position * radius;
        CGPoint gridLinePoint = [DrawUtils getCirclePoint:CGPointMake(centerX, centerY) radius:adjacent angle:angle];
        [gridLinePoints addObject:[NSValue valueWithCGPoint:gridLinePoint]];
        CGFloat hypotenuse = sqrt(pow(opposite, 2) + pow(adjacent, 2));
        CGFloat labelAngle = atan(opposite / adjacent);
        CGPoint labelPoint = CGPointMake(centerX + cos(angle + labelAngle)* hypotenuse, centerY + sinf(angle + labelAngle) * hypotenuse);
        labelPoint.x -= 0;//(size.width/3);
        labelPoint.y -= angle == 0 ? size.height : size.height / 2;
        if (label.position != 0)
        {
            [label.text drawWithBasePoint:labelPoint andAngle:angle andFont:[UIFont systemFontOfSize:fontSize]];
        }
        [self drawTick:adjacent];
    }
    [gridLinePoints addObject:[NSValue valueWithCGPoint:endPoint]];
}

- (void) drawTick : (int) position
{
    CGFloat opposite = tickLength /2 ;
    CGFloat adjacent = position;
    CGFloat hypotenuse = sqrt(pow(opposite, 2) + pow(adjacent, 2));
    CGFloat tickAngle = atan(opposite / adjacent);
    CGPoint tickStartPoint = CGPointMake(centerX + cos(angle - tickAngle) * hypotenuse, centerY + sin(angle - tickAngle) * hypotenuse);
    CGPoint tickEndPoint = CGPointMake(centerX + cos(angle + tickAngle) * hypotenuse, centerY + sin(angle + tickAngle) * hypotenuse);
    Line * line = [[Line alloc] initWithPoint:tickStartPoint endPoint:tickEndPoint];
    line.lineWidth = 1;
    line.strokeColor = [UIColor blackColor];
    [line drawHandler:context];
    
}

@end
