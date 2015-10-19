//
//  LabelPoint.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-21.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
@interface LabelPoint : NSObject
{
    float xLabel;
    float yLabel;
    float widthLabel;
    float size;
    float heightLabel;
    NSTextAlignment alignment;
    int index;
    double currtAngle;
    double angle;
}
@property(nonatomic) float xLabel;
@property(nonatomic) float yLabel;
@property(nonatomic) float widthLabel;
@property(nonatomic) float size;
@property(nonatomic) float heightLabel;
@property NSTextAlignment alignment;
@property(nonatomic) int index;
@property(nonatomic) double currtAngle;
@property(nonatomic) double angle;
- (id) init : (double) currtAngle angle : (double) angle index : (int)mIndex;
@end
