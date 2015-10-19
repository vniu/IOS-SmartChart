//
//  CALayer+Additions.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-25.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "CALayer+Additions.h"

@implementation CALayer (Additions)

- (void)bringSublayerToFront
{
    CALayer *superlayer = self.superlayer;
    [self removeFromSuperlayer];
    [superlayer insertSublayer:self atIndex:[self.sublayers count]-1];
}

- (void)sendSublayerToBack
{
    CALayer *superlayer = self.superlayer;
    [self removeFromSuperlayer];
    [superlayer insertSublayer:self atIndex:0];
}

@end
