//
//  ImageLayer.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-5.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "ImageLayer.h"
#import <GLKit/GLKit.h>

static inline double radians (double degrees) {return degrees * M_PI/180;}
@implementation ImageLayer

@synthesize drawPoint;
@synthesize imageRect;

- (id) init : (CGContextRef) ctx layerSize : (CGSize)mLayerSize
{
    self = [super init];
    if (self)
    {
        context = ctx;
        layerSize = mLayerSize;
    }
    return self;
}

- (void) drawImageOnLayer : (UIImage *) image degree : (CGFloat)angle
{
   // CGAffineTransform myTextTransform =CGAffineTransformRotate(CGAffineTransformIdentity, );
    CGContextRotateCTM(context, GLKMathDegreesToRadians(-45));
//    CGLayerRef cg = CGLayerCreateWithContext(context, layerSize, NULL);
//    //需要将CGLayerContext来作为缓存context，这个是必须的
//    CGContextRef layerContext = CGLayerGetContext(cg);
//    CGContextDrawImage(layerContext, imageRect, image.CGImage);
//    CGContextDrawLayerAtPoint(context, drawPoint, cg);
    CGLayerRef cg=CGLayerCreateWithContext(context, CGSizeMake(320, 480), NULL);
    //需要将CGLayerContext来作为缓存context，这个是必须的
    CGContextRef layerContext=CGLayerGetContext(cg);
    CGContextDrawImage(layerContext, imageRect, image.CGImage);
    CGContextDrawLayerAtPoint(context, CGPointMake(0, 0), cg);
    
   // CGContextRestoreGState(context);
 //////////////////
    CGAffineTransform myTextTransform =  CGAffineTransformMakeRotation( GLKMathDegreesToRadians(-45));
   CGContextConcatCTM(context, myTextTransform);
  
   // CGContextRotateCTM(context, GLKMathDegreesToRadians(-45));
    CGContextDrawImage(context, imageRect, image.CGImage);
}




@end
