//
//  AnimationUtils.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-20.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "AnimationUtils.h"
#import <UIKit/UIKit.h>

@implementation AnimationUtils



//永久闪烁的动画
+ (CABasicAnimation *)opacityForeverAnimation : (float)time 
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.0];
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = FLT_MAX;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}


//有闪烁次数的动画
+ (CABasicAnimation *)opacityTimesAnimation : (float)repeatTimes durTimes : (float)time 
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.4];
    animation.repeatCount = repeatTimes;
    animation.duration = time;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses = YES;
    return  animation;
}


//横向移动
+ (CABasicAnimation *)moveX : (float)time x : (NSNumber *)x
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.toValue = x;
    animation.duration = time;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}


//纵向移动
+ (CABasicAnimation *)moveY : (float)time y : (NSNumber *)y
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.toValue = y;
    animation.duration = time;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}


+ (CABasicAnimation *) frameAnimation
{
    CABasicAnimation *frameAnimation = [CABasicAnimation animation];
    frameAnimation.duration = 2.5;
    frameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //myLayer.actions = [NSDictionary dictionaryWithObjectsAndKeys:frameAnimation, @"frame", nil];
    return frameAnimation;
}





//缩放
+ (CABasicAnimation *)scale:(NSNumber *)multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time rep:(float)repeatTimes
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = orginMultiple;
    animation.toValue = multiple;
    animation.duration = time;
    animation.autoreverses = YES;
    animation.repeatCount = repeatTimes;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}


//组合动画
+ (CAAnimationGroup *)groupAnimation : (NSArray *)animationAry durTimes : (float)time rep : (float)repeatTimes
{
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = animationAry;
    animation.duration = time;
    animation.repeatCount = repeatTimes;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
    
}


//路径动画
+ (CAKeyframeAnimation *)keyframeAniamtion : (CGMutablePathRef)path durTimes : (float)time rep : (float)repeatTimes
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses = NO;
    animation.duration = time;
    animation.repeatCount = repeatTimes;
    return animation;
    
}

//点移动
+ (CABasicAnimation *)movepoint:(CGPoint )point 
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
    animation.toValue = [NSValue valueWithCGPoint:point];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}


//旋转
+ (CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount 
{
    CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0, 0,direction);
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration = dur;
    animation.autoreverses = NO;
    animation.cumulative = YES;
    animation.removedOnCompletion = NO;
    animation.fillMode=kCAFillModeForwards;
    animation.repeatCount = repeatCount;
    animation.delegate = self;
    return animation;
}



+ (CABasicAnimation *) addPathAnimation : (CALayer *)layer fromPath : (CGMutablePathRef) fromPath toPath : (CGMutablePathRef) toPath delegate : (id)delegate
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
	animation.duration = 2.0;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	//animation.repeatCount = //HUGE_VALF;
	animation.autoreverses = NO;
	animation.fromValue = (__bridge_transfer id)fromPath;
	animation.toValue = (__bridge_transfer id)toPath;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = delegate;
	[layer addAnimation:animation forKey:@"animatePath"];
    return animation;
}


@end
