//
//  SCGradientLayer.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-24.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "SCGradientLayer.h"
#import "UIColor+ChartColor.h"

@implementation SCGradientLayer

@synthesize text ;
@synthesize value ;
@synthesize startValue;
@synthesize endValue;
@synthesize isSelected;
@synthesize left;
@synthesize rectWidth;
@synthesize height;
@synthesize seriesIndex;
@synthesize bottom;
- (id) init : (UIColor *)gradientColor
{
    self = [super init];
    if (self)
    {
        NSMutableArray * gradientColors = [NSMutableArray array];
        [gradientColors addObject:(id)[gradientColor lightColor:0.1].CGColor];
        [gradientColors addObject:(id)gradientColor.CGColor];
        self.colors = gradientColors;
    }
    return self;
}

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
        if ([layer isKindOfClass:[SCGradientLayer class]])
        {
            self.startValue = [(SCGradientLayer *)layer startValue];
            self.endValue = [(SCGradientLayer *)layer endValue];
        }
    }
    return self;
}

- (void) setPropertyHandler : (CGFloat)mLeft height : (CGFloat)mHeight rectWidth : (CGFloat)mRectWidth bottom : (CGFloat)mBottom
{
    left = mLeft;
    height = mHeight;
    rectWidth = mRectWidth;
    bottom = mBottom;
    
}
- (void)setValueHandler : (CGFloat) mValue
{
    value = mValue;
}

- (void) setFrameHandler : (CGRect)mFrame
{
    self.frame = mFrame;
}

- (CGFloat) getValueHandler
{
    return value;
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

@end
