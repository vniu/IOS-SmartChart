//
//  BaseLayer.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-21.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "BaseLayer.h"
#import "UIColor+ChartColor.h"

@implementation BaseLayer
@synthesize text ;
@synthesize value ;
@synthesize startValue;
@synthesize endValue;
@synthesize isSelected;
@synthesize seriesIndex;
+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"startValue"] || [key isEqualToString:@"endValue"])
    {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (id)initWithLayer:(id)layer
{
    if (self = [super initWithLayer:layer])
    {
        if ([layer isKindOfClass:[BaseLayer class]])
        {
            self.startValue = [(BaseLayer *)layer startValue];
            self.endValue = [(BaseLayer *)layer endValue];
        }
    }
    return self;
}


- (void) setSeriesIndex:(CGFloat)index
{
    seriesIndex = index;
}

- (CGFloat) getSeriesIndex
{
    return seriesIndex;
}

- (void)createAnimationForKey:(NSString *)key fromValue:(NSNumber *)from toValue:(NSNumber *)to delegate:(id)delegate
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:key];
    NSNumber * currentValue = [[self presentationLayer] valueForKey:key];
    if(!currentValue) currentValue = from;
    [animation setFromValue:currentValue];
    [animation setToValue:to];
    [animation setDelegate:delegate];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self addAnimation:animation forKey:key];
    [self setValue:to forKey:key];
}

+ (CATextLayer *) createTextLayer : (UIColor *)labelColor
{
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.contentsScale = [[UIScreen mainScreen] scale];
    UIFont * labelFont = [UIFont systemFontOfSize:15.0];
    CGFontRef font = CGFontCreateWithFontName((__bridge CFStringRef)[labelFont fontName]);
    [textLayer setFont:font];
    CFRelease(font);
    [textLayer setFontSize:labelFont.pointSize];
    [textLayer setAnchorPoint:CGPointMake(0.5, 0.5)];
    [textLayer setAlignmentMode:kCAAlignmentCenter];
    [textLayer setBackgroundColor:[UIColor clearColor].CGColor];
    [textLayer setForegroundColor:labelColor.CGColor];
    if (labelColor)
    {
        [textLayer setShadowColor:labelColor.CGColor];
        [textLayer setShadowOffset:CGSizeZero];
        [textLayer setShadowOpacity:1.0f];
        [textLayer setShadowRadius:2.0f];
    }
    return textLayer;
}


@end
