//
//  AreaShapeLayer.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-25.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "BaseLayer.h"

@interface AreaShapeLayer : BaseLayer
{
    CGMutablePathRef pathRef;
}

@property (nonatomic) CGMutablePathRef pathRef;

- (void)drawPath;

- (void) moveToPoint : (CGPoint) point;
- (void) addLineToPoint : (CGPoint) point;
@end
