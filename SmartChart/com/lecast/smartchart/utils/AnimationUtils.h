//
//  AnimationUtils.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-20.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface AnimationUtils : NSObject
+ (CAKeyframeAnimation *) keyframeAniamtion : (CGMutablePathRef)path durTimes:(float)time rep : (float)repeatTimes ;

+ (CABasicAnimation *) addPathAnimation : (CALayer *)layer fromPath : (CGMutablePathRef) fromPath toPath : (CGMutablePathRef) toPath delegate : (id)delegate;
@end
