//
//  DrawUtils.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "DrawUtils.h"
#import <GLKit/GLKit.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@implementation DrawUtils

+ (UIColor*) getRandomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];//CGColor;
}

+ (CGSize) getTextRect : (NSString *)textValue fontSize : (float)fontSize
{
    UIFont * font = [UIFont systemFontOfSize:fontSize];
    return [textValue sizeWithFont:font];
}

+ (void) drawText : (NSString *)text point : (CGPoint)point fontSize : (float)fontSize
{
    CGSize textSize = [DrawUtils getTextRect:text fontSize:fontSize];
    CGRect textRect = CGRectMake(point.x, point.y, textSize.width, textSize.height);
    [text drawInRect:textRect withFont:[UIFont systemFontOfSize:fontSize] lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentLeft];
}

+ (CGPoint) getCirclePoint: (CGPoint) certer radius : (CGFloat) radius angle : (CGFloat) angle
{
	while (angle >= 360)
    {
		angle = angle - 360;
	}
	CGPoint point;
	if (angle == 0)
    {
		point = CGPointMake(radius, 0);
		return CGPointMake(point.x+certer.x, point.y+certer.y);
	}
	if (angle == 90)
    {
		point = CGPointMake(0, radius);
		return CGPointMake(point.x+certer.x, point.y+certer.y);
	}
	if (angle == 180)
    {
		point = CGPointMake(-radius, 0);
		return CGPointMake(point.x+certer.x, point.y+certer.y);
	}
	if (angle == 270)
    {
		point = CGPointMake(0, -radius);
		return CGPointMake(point.x+certer.x, point.y+certer.y);
	}
	double t = tan(angle * M_PI/180.0);
	double x = radius/sqrt(1+pow(t, 2.0));
	double y = t * x;
    point = (angle < 90 || angle > 270) ? point = CGPointMake(x, y) : CGPointMake(-x, -y);
	return CGPointMake(point.x+certer.x, point.y+certer.y);
}



+ (void) drawTextOnDegrees : (CGContextRef)context text: (NSString *)labelText point : (CGPoint)point fontSize : (float)fontSize degrees : (float)degrees
{
    UIGraphicsPushContext(context);
    UIFont  * font = [UIFont systemFontOfSize:fontSize];
    //UIFont  * font = [UIFont fontWithName:@"Arial-BoldMT" size:25];
    CGContextSelectFont (context, "Arial", 24, kCGEncodingMacRoman);
    //CGContextSetFont(context, (__bridge CGFontRef)font);
    CGContextSetCharacterSpacing (context, 10);
    CGContextSetTextDrawingMode (context, kCGTextFill);
    CGContextSetGrayFillColor(context, 0.0, 1.0);
    CGAffineTransform myTextTransform = CGAffineTransformRotate(CGAffineTransformScale(CGAffineTransformIdentity, 1.f, -1.f ),degrees * M_PI / 180);
    CGContextSetTextMatrix (context, myTextTransform);
   
//    [labelText drawAtPoint:point forWidth:[DrawUtils getTextRect : labelText fontSize : fontSize].width withFont:font fontSize:fontSize lineBreakMode:NSLineBreakByWordWrapping baselineAdjustment:UIBaselineAdjustmentNone];
    CGContextShowTextAtPoint (context, point.x, point.y, [labelText UTF8String], fontSize);
    UIGraphicsPopContext();
    
    
//    CGAffineTransform myTextTransform; // 2
//    CGContextSetFont(context, (__bridge CGFontRef)font);
//    CGContextSelectFont(context, // 3
//                         [labelText UTF8String],
//                         fontSize,
//                         kCGEncodingMacRoman);
//    CGContextSetCharacterSpacing (context, 10); // 4
//    CGContextSetTextDrawingMode (context, kCGTextFillStroke); // 5
//    CGContextSetRGBFillColor(context, 0, 1, 0, .5); // 6
//    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1); // 7
//    myTextTransform =  CGAffineTransformMakeRotation  (GLKMathDegreesToRadians (-90)); // 8
//    CGContextSetTextMatrix (context, myTextTransform); // 9
//    CGContextShowTextAtPoint (context, point.x, point.y, [labelText UTF8String], fontSize);
    
    
    

//    CGContextSaveGState(context);
//    
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    
//    // Create the gradient
//    CGColorRef startColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
//    CGColorRef endColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0].CGColor;
//    NSArray *colors = [NSArray arrayWithObjects:(id)startColor, (id)endColor, nil];
//    CGFloat locations[] = { 0.0, 1.0 };
//    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef) colors, locations);
//    CGContextDrawLinearGradient(context, gradient, CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y), CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height), 0);
//    
//    // Create text
//    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
//    NSString *string = @"some test string";
//    UIFont *font = [UIFont systemFontOfSize:16.0];
//    
//    // Rotate the context 90 degrees (convert to radians)
//    CGAffineTransform transform1 = CGAffineTransformMakeRotation(-90.0 * M_PI/180.0);
//    CGContextConcatCTM(context, transform1);
//    
//    // Move the context back into the view
//    CGContextTranslateCTM(context, -rect.size.height, 0);
//    
//    // Draw the string
//    [string drawInRect:rect withFont:font lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
//    
//    // Clean up
//    CGGradientRelease(gradient);
//    CGColorSpaceRelease(colorSpace);
//    
//    CGContextRestoreGState(context);
    
   
}


- (void) drawImage : (CGContextRef) ctx image  :(UIImage *) image
{
    CGContextDrawImage(ctx, CGRectMake(160, 0, 160, 230), [image CGImage]);
}

- (UIImage *)imageFromText : (NSString *)text width : (float)width height : (float)height
{
    UIFont *font = [UIFont systemFontOfSize:12.0];
    CGSize size  = CGSizeMake(width, height);
    [text sizeWithFont:font];
    if (UIGraphicsBeginImageContextWithOptions != NULL)
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    else
        UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetShadowWithColor(ctx, CGSizeMake(1.0, 1.0), 5.0, [[UIColor grayColor] CGColor]);
    [text drawInRect:CGRectMake(0, 0, width, height) withFont:font];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void) drawLine
{
//
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(50.0,0.0)];
//    [path addLineToPoint:CGPointMake(120.0, 600.0)];
//
//    CAShapeLayer *pathLayer = [CAShapeLayer layer];
//    pathLayer.frame = view.bounds;
//    pathLayer.path = path.CGPath;
//    pathLayer.strokeColor = [[UIColor redColor] CGColor];
//    pathLayer.fillColor = nil;
//    pathLayer.lineWidth = 2.0f;
//    pathLayer.lineJoin = kCALineJoinBevel;
//
//    [view.layer addSublayer:pathLayer];
//
//    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation.duration = 2.0;
//    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
//    [areaLayer addAnimation:pathAnimation forKey:@"strokeEnd"];

}




@end
