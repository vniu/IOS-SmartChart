//
//  Series.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Series.h"
#import <QuartzCore/QuartzCore.h>
@implementation Series

@synthesize shapeLayers;
@synthesize stroke;
@synthesize valueField;
@synthesize dataProvider;
@synthesize pointMapping;
@synthesize displayName;
@synthesize fontSize;
@synthesize offsetX, offsetY, scale, dataSize;
@synthesize propertyValues;
@synthesize labelColor;
@synthesize chartView;
@synthesize context;

- (void) main
{
    [self onDrawHandler:chartView];
}

- (void) onDrawHandler : (UIView*)view
{
    
}

- (void) setDataProviderHandler : (NSMutableArray *) mDataProvider
{
    dataProvider = mDataProvider;
    dataSize = [dataProvider count];
    [self filterValueHandler];
}

- (void) filterValueHandler
{
    propertyValues = [[NSMutableArray alloc] init];
    for (NSObject * object in dataProvider)
    {
        NSString * value =  nil;
        if ([object isKindOfClass:[NSMutableDictionary class]])
        {
            NSMutableDictionary * dict = (NSMutableDictionary *)object;
            value = [dict objectForKey:valueField] ;
        }
        else
        {
            value = [object valueForKey:valueField];
        }
        [propertyValues addObject: value];
    }
}

- (void) initGraphicsContext  : (CGContextRef)mContext
{
    context = mContext;
}

- (void) setOffset : (float) mOffsetX offsetY : (float) mOffsetY
{
    offsetX = mOffsetX;
    offsetY = mOffsetY;
}

- (void)animationDidStart : (CAAnimation *)anim
{
    if (![self respondsToSelector:@selector(updateShapeHandler:)])
    {
        return;
    }
    if (animationTimer == nil)
    {
        static float timeInterval = 1.0/15.0;
        animationTimer = [NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(updateShapeHandler:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:animationTimer forMode:NSRunLoopCommonModes];
    }
    [animations addObject:anim];
}

- (void)animationDidStop : (CAAnimation *)anim finished : (BOOL)flag
{
    [animations removeObject:anim];
    if ([animations count] == 0)
    {
        [animationTimer invalidate];
        animationTimer = nil;
        [self updateOnStopHandler];
    }
}

- (void) updateOnStopHandler
{
    
    
    
}

@end
