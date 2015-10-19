//
//  SCGradientLayer.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-24.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BaseLayer.h"
#import "ICAlayer.h"
@interface SCGradientLayer : CAGradientLayer<ICALayer>
{
    CGFloat value;
    double startValue;
    double endValue;
    BOOL isSelected;
    NSString * text;
    CGFloat left;
    CGFloat rectWidth;
    CGFloat height;
    CGFloat bottom;
    CGFloat seriesIndex;
}
@property (nonatomic, assign) CGFloat value;
@property (nonatomic, assign) CGFloat percentage;
@property (nonatomic, assign) double startValue;
@property (nonatomic, assign) double endValue;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) NSString  *text;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat rectWidth;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat seriesIndex;

- (id) init : (UIColor *)gradientColor;
@end
