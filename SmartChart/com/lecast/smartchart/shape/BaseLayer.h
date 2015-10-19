//
//  BaseLayer.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-21.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ICAlayer.h"
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
@interface BaseLayer : CAShapeLayer <ICALayer>
{
    CGFloat value;
    double startValue;
    double endValue;
    BOOL isSelected;
    NSString * text;
    CGFloat seriesIndex;
    
}
@property (nonatomic, assign) CGFloat value;
@property (nonatomic, assign) CGFloat percentage;
@property (nonatomic, assign) double startValue;
@property (nonatomic, assign) double endValue;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) NSString  *text;
@property (nonatomic) CGFloat seriesIndex;
+ (CATextLayer *) createTextLayer : (UIColor *)labelColor;
@end
