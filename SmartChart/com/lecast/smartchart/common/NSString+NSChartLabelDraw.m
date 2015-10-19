//
//  NSString+NSChartLabelDraw.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-18.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "NSString+NSChartLabelDraw.h"
#import <GLKit/GLKit.h>

@implementation NSString (NSChartLabelDraw)


-(void)  drawWithBasePoint : (CGPoint) basePoint andAngle : (CGFloat) angle andFont : (UIFont *) font
{
    CGSize  textSize = [self sizeWithFont:font];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGAffineTransform   t = CGAffineTransformMakeTranslation(basePoint.x, basePoint.y);
    CGAffineTransform   r = CGAffineTransformMakeRotation(GLKMathDegreesToRadians(angle));
    CGContextConcatCTM(context, t);
    CGContextConcatCTM(context, r);
    [self drawAtPoint:CGPointMake(-1 * textSize.width / 2, -1 * textSize.height / 2)
               withFont:font];
    CGContextConcatCTM(context, CGAffineTransformInvert(r));
    CGContextConcatCTM(context, CGAffineTransformInvert(t));
}
@end
