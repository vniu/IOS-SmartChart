//
//  LabelPoint.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-21.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "LabelPoint.h"

@implementation LabelPoint
@synthesize xLabel;
@synthesize yLabel;
@synthesize widthLabel;
@synthesize size;
@synthesize alignment;
@synthesize heightLabel;
@synthesize index;
@synthesize currtAngle;
@synthesize angle;

- (id) init : (double) mCurrtAngle angle : (double) mAngle index : (int)mIndex
{
    self = [super init];
    if (self)
    {
        currtAngle = mCurrtAngle;
        angle = mAngle;
        index = mIndex;
    }
    return  self;
}

@end
