//
//  Stroke.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-17.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Stroke.h"

@implementation Stroke
@synthesize strokeColor;
@synthesize textColor;
@synthesize fillColor;
- (id) init : (UIColor *)mStrokeColor textColor : (UIColor *) mTextColor
{
    self = [super init];
    if (self)
    {
        strokeColor = mStrokeColor;
        textColor = mTextColor;
    }
    return self;
}

- (id) init : (UIColor *)mStrokeColor fillColor : (UIColor *)mFillColor
{
    self = [super init];
    if (self)
    {
        strokeColor = mStrokeColor;
        fillColor = mFillColor;
    }
    return self;
}

@end
