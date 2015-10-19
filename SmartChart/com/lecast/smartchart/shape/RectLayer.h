//
//  RectLayer.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-21.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BaseLayer.h"

@interface RectLayer : BaseLayer
{
    CGMutablePathRef rectPath;
    CGAffineTransform transform;
    const CGAffineTransform * fm;
    CGFloat left;
    CGFloat rectWidth;
    CGFloat height;
    CGFloat bottom;
}

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat rectWidth;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat bottom;
+ (RectLayer *)createRectLayer : (UIColor *)labelColor;
- (void)drawPath : (CGRect) rect;
@end
