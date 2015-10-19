//
//  RadialGradient.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-5.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gradient.h"

@interface RadialGradient : Gradient<IGradientDraw>
{
    CGFloat centerX;
    CGFloat centerY;
    CGFloat radius;
}

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat radius;


- (id)init : (CGContextRef)mContext;

@end
