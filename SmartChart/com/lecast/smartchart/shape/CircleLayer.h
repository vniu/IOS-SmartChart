//
//  CircleLayer.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-31.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "BaseLayer.h"

@interface CircleLayer : BaseLayer
{
    CGMutablePathRef pathRef;
}
- (void)drawPath : (CGPoint) centerPoint radius : (CGFloat) mRadius;
+ (CircleLayer *)createCircleLayer : (UIColor *)labelColor;
@end
