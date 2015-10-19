//
//  Shape.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-21.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Shape.h"

@implementation Shape
@synthesize fillColor;
@synthesize strokeColor;
@synthesize lineWidth;
@synthesize transform;
@synthesize gradients;

-(id) initWithLineWidth : (float) width
{
    self = [super init];
    if (self)
    {
        lineWidth = width;
        transform=CGAffineTransformMakeTranslation(0,0);
    }
    return self;
}
-(id) initWithStrokeColor : (UIColor *)color
{
    self = [super init];
    if (self)
    {
        lineWidth = 1.0;
        strokeColor = color;
        transform=CGAffineTransformMakeTranslation(0,0);
    }
    return self;
}
-(id) initWithFillColor : (UIColor *) color
{
     self = [self initWithLineWidth:1.0];
    if (self)
    {
        fillColor = color;
    }
    return self;
}
-(id) initWithStrokeColor : (UIColor *)mStrokeColor fillColor : (UIColor *)fcolor
{
    self = [self initWithStrokeColor:mStrokeColor];
    if (self)
    {
        strokeColor = mStrokeColor;
        fillColor = fcolor;
    }
    return self;
    
}
-(id) initWithStrokeColor : (UIColor *)mStrokeColor fillColor : (UIColor *)fcolor lineWidth : (float) width
{
    self = [self initWithStrokeColor:mStrokeColor fillColor:fcolor];
    if (self)
    {
        lineWidth = width;
    }
    return self;
}

-(BOOL) initContext : (CGContextRef) context
{
    if (context)
    {
		CGContextSaveGState(context);
        CGContextSetAllowsAntialiasing(context, YES);
		CGContextSetLineWidth(context, self.lineWidth);
		if (self.strokeColor)
        {
			CGContextSetStrokeColorWithColor(context, [strokeColor CGColor]);//[self.strokeColor CGColor]);
		}
		if (self.fillColor)
        {
			CGContextSetFillColorWithColor(context, [fillColor CGColor]);
		}
		CGAffineTransform trans = CGContextGetUserSpaceToDeviceSpaceTransform(context);
		if (!CGAffineTransformEqualToTransform(transform, CGAffineTransformMake(0, 0, 0, 0, 0, 0)))
        {
			trans = CGAffineTransformConcat(trans, transform);
			CGContextConcatCTM(context, trans);
		}
		return YES;
	}
	return NO;
}

-(void) drawFinish : (CGContextRef) context
{
    CGContextRestoreGState(context);
}

-(void) fillStrokePath:(CGContextRef) context pathRef:(CGMutablePathRef) pathRef
{
	CGPathCloseSubpath(pathRef);
	BOOL isFill = NO;
	if (self.fillColor && self.strokeColor && self.lineWidth > 0)
    {
        CGContextDrawPath(context, kCGPathFillStroke);
        isFill=YES;
	}
	else
    {
		if (self.fillColor)
        {
			CGContextDrawPath(context, kCGPathFill);
			isFill=YES;
		}
		if (self.strokeColor && self.lineWidth > 0)
        {
			isFill=YES;
			CGContextDrawPath(context, kCGPathStroke);
		}
	}
	if (self.gradients.count > 0)
    {
        for (int i=0; i<self.gradients.count; i++)
        {
            if (isFill || i > 0)
            {
                CGContextAddPath(context,pathRef);
            }
            CGContextSaveGState(context);
            CGContextClip(context);
            //[[self.gradients objectAtIndex:i] fillImage:context];
        }
	}
}
@end
