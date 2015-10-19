//
//  PieSeries.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "PieSeries.h"


@implementation PieSeries
static NSUInteger kDefaultSliceZOrder = 100;
@synthesize showPercentage;
@synthesize selectedSliceIndex;
@synthesize labels;
-(id) init
{
    self = [super init];
    if (self)
    {
        animations = [[NSMutableArray alloc] init];
        selectedSliceOffsetRadius = MAX(10, radius/10);
        showPercentage = YES;
        showLabel = YES;
        selectedSliceIndex = -1;
        labelBounds = [[NSMutableArray alloc] init];
        labels = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) onDrawHandler : (UIView*) view
{
    [super onDrawHandler:view];
    [labelBounds removeAllObjects];
    pieView = view;
    CGPoint pieCenter = CGPointMake(centerX, centerY);
    float shortRadius = radius * 0.9f;
    float longRadius = radius * 1.2f;
    labelDrawer = [[RoundLabelDrawer alloc] init:context centerPoint: pieCenter shortRadius:shortRadius longRadius:longRadius labelColor:labelColor];
    labelDrawer.radius = radius;
    labelDrawer.fontSize = fontSize;
    CALayer * parentLayer = [view layer];
    NSArray *slicelayers = [parentLayer sublayers];
    float totalValue = 0;
    for (int index = 0;index < dataSize; index++)
    {
        totalValue += [[propertyValues objectAtIndex:index] floatValue];
    }
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [view setUserInteractionEnabled:NO];
    __block NSMutableArray *layersToRemove = nil;
    [CATransaction setCompletionBlock:^{
        [layersToRemove enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj removeFromSuperlayer];
        }];
        [layersToRemove removeAllObjects];
        for(SliceLayer *layer in parentLayer.sublayers)
        {
            [layer setZPosition:kDefaultSliceZOrder];
        }
        [view setUserInteractionEnabled:YES];
    }];
    BOOL isOnStart = [slicelayers count] == 0 && dataSize;
    NSInteger diff = dataSize - [slicelayers count];
    layersToRemove = [NSMutableArray arrayWithArray:slicelayers];
    double startPieAngle = 0;//M_PI_2*3;
    double startToAngle = 0.0;
    double endToAngle = startToAngle;
    float drawAngle = 0;
    for (int index = 0; index < dataSize; index++)
    {
        SliceLayer *layer;
        UIColor * color = [colorsCache objectAtIndex:index];
        float value = [[propertyValues objectAtIndex:index] floatValue];
        double precentValue = value * 100 / totalValue;
        double angle = (double) (value / totalValue * M_PI * 2);
        double startFromAngle = startPieAngle + startToAngle;
        double endFromAngle = startPieAngle + endToAngle;
        drawAngle = value / totalValue * 360;
        [self addClickPoint:index angle:drawAngle];
        if (showLabel)
        {
            NSString * labelValue = [self getCategoryName:index];
            [labels addObject:labelValue];
            [labelDrawer drawLabel: labelValue currentAngle:endToAngle angle:angle];
        }
        endToAngle += angle;
        if( index >= [slicelayers count] )
        {
            layer = [SliceLayer createSliceLayer:labelColor centerPoint:pieCenter];
            if (isOnStart)
            {
                startFromAngle = endFromAngle = startPieAngle;
            }
            [parentLayer addSublayer:layer];
            diff--;
        }
        else
        {
            SliceLayer *onelayer = [slicelayers objectAtIndex:index];
            if (diff > 0)
            {
                layer = onelayer;
                [parentLayer insertSublayer:layer atIndex:index];
                diff--;
            }
            else if(diff < 0)
            {
                while(diff < 0)
                {
                    [onelayer removeFromSuperlayer];
                    [parentLayer addSublayer:onelayer];
                    diff++;
                    onelayer = [slicelayers objectAtIndex:index];
                    if(onelayer.value == value || diff == 0)
                    {
                        layer = onelayer;
                        [layersToRemove removeObject:layer];
                        break;
                    }
                }
            }
        }
        [self updateLabelForLayer:layer value:precentValue];
        layer.value = value;
        layer.percentage = precentValue;
        [layer setFillColor:color.CGColor];
        [layer createAnimationForKey:@"startValue"
                              fromValue:[NSNumber numberWithDouble:startFromAngle]
                                toValue:[NSNumber numberWithDouble:startToAngle+startPieAngle]
                               delegate:self];
        NSLog(@"startAngle %f+++++ %f",startFromAngle,startToAngle+startPieAngle);
        [layer createAnimationForKey:@"endValue"
                              fromValue:[NSNumber numberWithDouble:endFromAngle]
                                toValue:[NSNumber numberWithDouble:endToAngle+startPieAngle]
                               delegate:self];
         NSLog(@"endAngle %f+++++ %f",endFromAngle,endToAngle+startPieAngle);    
        startToAngle = endToAngle;
    }
    [CATransaction setDisableActions:YES];
    for(SliceLayer *layer in layersToRemove)
    {
        [layer setFillColor:[view backgroundColor].CGColor];
        [layer setDelegate:nil];
        [layer setZPosition:0];
        CATextLayer *textLayer = [[layer sublayers] objectAtIndex:0];
        [textLayer setHidden:YES];
    }
    [CATransaction setDisableActions:NO];
    [CATransaction commit];
}

- (void)updateShapeHandler:(NSTimer *)timer
{
    
    CALayer *parentLayer = [pieView layer];
    NSArray *pieLayers = [parentLayer sublayers];
    [pieLayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        
        NSNumber *presentationLayerStartAngle = [[obj presentationLayer] valueForKey:@"startValue"];
        CGFloat interpolatedStartAngle = [presentationLayerStartAngle doubleValue];
        NSNumber *presentationLayerEndAngle = [[obj presentationLayer] valueForKey:@"endValue"];
         NSLog(@"updateTimerFired%@%@----------%@", @"---updateTimerFired", presentationLayerStartAngle, presentationLayerEndAngle);
        CGFloat interpolatedEndAngle = [presentationLayerEndAngle doubleValue];
        CGPoint pieCenter = CGPointMake(centerX, centerY);
        CGPathRef path = CGPathCreateArc(pieCenter, radius, interpolatedStartAngle, interpolatedEndAngle);
        [(CAShapeLayer*)obj setPath:path];
        CFRelease(path);
        {
            CATextLayer *labelLayer = [[obj sublayers] objectAtIndex:0];
            CGFloat interpolatedMidAngle = (interpolatedEndAngle + interpolatedStartAngle) / 2;
            [CATransaction setDisableActions:YES];
            [labelLayer setPosition:CGPointMake(pieCenter.x + (radius/2 * cos(interpolatedMidAngle)), pieCenter.y + (radius/2 * sin(interpolatedMidAngle)))];
            [CATransaction setDisableActions:NO];
        }
    }];
    NSLog(@"updateTimerFired%@",@"---updateTimerFired");
}

- (void)updateLabelForLayer : (SliceLayer *)pieLayer value : (CGFloat)value
{
    CATextLayer *textLayer = [[pieLayer sublayers] objectAtIndex:0];
    [textLayer setHidden:!showPercentage];
    NSString * label = [NSString stringWithFormat:@"%0.0f%@", value, @"%"];
    UIFont * labelFont = [UIFont systemFontOfSize:15.0];
    CGSize size = [label sizeWithFont:labelFont];
    [CATransaction setDisableActions:YES]; 
    if(M_PI*2*10*pieLayer.percentage < MAX(size.width,size.height) || value <= radius/2)
    {
        [textLayer setString:label];
    }
    else
    {
        [textLayer setString:label];
        [textLayer setBounds:CGRectMake(0, 0, size.width, size.height)];
    }
    [CATransaction setDisableActions:NO];
}


static CGPathRef CGPathCreateArc(CGPoint center, CGFloat radius, CGFloat startAngle, CGFloat endAngle)
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, center.x, center.y);
    CGPathAddArc(path, NULL, center.x, center.y, radius, startAngle, endAngle, 0);
    CGPathCloseSubpath(path);
    return path;
}

- (void)notifySelectionChangeFrom : (NSUInteger)previousSelection to : (NSUInteger)newSelection
{
    if (previousSelection != newSelection)
    {
        selectedSliceIndex = newSelection;
        if (newSelection != -1)
        {
            [self setSliceSelectedAtIndex:newSelection];
        }
        if(previousSelection != -1)
        {
            [self setSliceDeselectedAtIndex:previousSelection];
        }
    }
    else if (newSelection != -1)
    {
        SliceLayer *layer = [pieView.layer.sublayers objectAtIndex:newSelection];
        if(selectedSliceOffsetRadius > 0 && layer)
        {
            if (layer.isSelected)
            {
                [self setSliceDeselectedAtIndex:newSelection];
                return;
            }
            [self setSliceSelectedAtIndex:newSelection];
        }
    }
}

- (void)setSliceSelectedAtIndex : (NSInteger)index
{
    if(selectedSliceOffsetRadius <= 0)
        return;
    SliceLayer *layer = [pieView.layer.sublayers objectAtIndex:index];
    if (layer && !layer.isSelected)
    {
        CGPoint currPos = layer.position;
        double middleAngle = (layer.startValue + layer.endValue)/2.0;
        CGPoint newPos = CGPointMake(currPos.x + selectedSliceOffsetRadius*cos(middleAngle), currPos.y + selectedSliceOffsetRadius*sin(middleAngle));
        layer.position = newPos;
        layer.isSelected = YES;
    }
}

- (void)setSliceDeselectedAtIndex : (NSInteger)index
{
    if(selectedSliceOffsetRadius <= 0)
        return;
    SliceLayer *layer = [pieView.layer.sublayers objectAtIndex:index];
    if (layer && layer.isSelected)
    {
        layer.position = CGPointMake(0, 0);
        layer.isSelected = NO;
    }
}

@end
