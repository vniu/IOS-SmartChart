//
//  RoundLabelDrawer.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-21.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LabelPoint.h"

@interface RoundLabelDrawer : NSObject
{
    CGContextRef context;
    CGPoint centerPoint;
    float shortRadius;
    float longRadius;
    UIColor * labelColor;
    NSMutableArray * prevLabelsBounds;
    float fontSize;
    float radius;
}

@property(nonatomic) float fontSize;
@property(nonatomic) float radius;
- (id) init : (CGContextRef)mcontext centerPoint : (CGPoint)mCenterPoint shortRadius : (float)mShortRadius longRadius : (float)mLongRadius labelColor : (UIColor *)mLabelcolor;
- (LabelPoint *) getTextPoint : (NSString *)labelText currentAngle : (float)currentAngle angle : (float)angle;
- (void) drawLabel : (NSString *)labelText currentAngle : (float)currentAngle angle : (float)angle ;
- (void) clear;

@end
