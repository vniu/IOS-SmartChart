//
//  Circle.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-22.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Shape.h"

@interface Circle : Shape<IShape>
{
    CGPoint centerPoint;
    CGFloat radius;
    CGMutablePathRef pathRef;
    BOOL isRadialGradient;
}


@property (nonatomic) CGPoint centerPoint;
@property (nonatomic) CGFloat radius;
@property (nonatomic) BOOL isRadialGradient;

- (id) init : (CGPoint) mCenterPoint radius : (CGFloat) mRadius;
@end
