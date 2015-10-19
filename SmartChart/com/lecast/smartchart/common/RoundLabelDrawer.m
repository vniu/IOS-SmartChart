//
//  RoundLabelDrawer.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-21.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "RoundLabelDrawer.h"
#import <GLKit/GLKit.h>

@implementation RoundLabelDrawer
@synthesize fontSize;
@synthesize radius;
-(id) init : (CGContextRef)mcontext centerPoint : (CGPoint)mCenterPoint shortRadius : (float)mShortRadius longRadius : (float)mLongRadius labelColor : (UIColor *)mLabelcolor
{
    self = [super init];
    if (self)
    {
        context = mcontext;
        centerPoint = mCenterPoint;
        shortRadius = mShortRadius;
        longRadius = mLongRadius;
        labelColor = mLabelcolor;
        prevLabelsBounds = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) drawLabel : (NSString *)labelText currentAngle : (float)currentAngle angle : (float)angle
{
    CGContextSetShouldAntialias(context, YES);
    CGContextSetShouldSmoothFonts(context, YES);
   // CGContextSetTextDrawingMode(context, kCGTextFillStroke);
    BOOL line = YES;
    LabelPoint *labelPoint = [self getTextPoint:labelText currentAngle:currentAngle angle:angle];
    NSArray * texts = [labelText componentsSeparatedByString:@"/"];
    for (int index = 0; index < texts.count; index++)
    {
        NSString * textValue = [texts objectAtIndex:index];
        CGRect textRect = CGRectMake(labelPoint.xLabel, labelPoint.yLabel - 10, labelPoint.widthLabel, labelPoint.heightLabel);
        [textValue drawInRect:textRect withFont:[UIFont systemFontOfSize:fontSize] lineBreakMode:NSLineBreakByCharWrapping alignment:labelPoint.alignment];
        labelPoint.yLabel = labelPoint.yLabel + labelPoint.heightLabel/2 + 2;
    }
    if (line)
    {
        CGRect textRect = CGRectMake(labelPoint.xLabel, labelPoint.yLabel, labelPoint.widthLabel, labelPoint.heightLabel);
        [prevLabelsBounds addObject:[NSValue valueWithCGRect:textRect]];
    }
    //CGContextRestoreGState(context);
}

- (LabelPoint *) getTextPoint : (NSString *)labelText currentAngle : (float)currentAngle  angle : (float)angle
{
    UIScreen * screen = [UIScreen mainScreen];
    float screenWidth = screen.bounds.size.width;
    LabelPoint * labelPoint = [[LabelPoint alloc] init];
    BOOL line = YES;
    double rAngle = M_PI_2 - (currentAngle + angle / 2);
    double sinValue = sin(rAngle);
    double cosValue = cos(rAngle);
    int x1 = round(centerPoint.x + (float) (shortRadius * sinValue));
    int y1 = round(centerPoint.y + (float) (shortRadius * cosValue));
    int x2 = round(centerPoint.x + (float) (longRadius * sinValue));
    int y2 = round(centerPoint.y + (float) (longRadius * cosValue)) ;
    float xLabel = 0;
    UIFont * font = [UIFont systemFontOfSize:fontSize];
    CGSize stringBoundingBox = [labelText sizeWithFont:font];
    float extra = MAX(fontSize / 2, 10);
    int maxSpaceSize = x1 > x2 ? screenWidth/2 - radius : screenWidth - x2;
    float factor = stringBoundingBox.width/maxSpaceSize;
    factor = factor < 1 ? 1 :  (factor+2);
    CGSize textMaxSize = CGSizeMake(maxSpaceSize, factor * stringBoundingBox.height);
    CGSize  textSize = [labelText sizeWithFont:font constrainedToSize:textMaxSize lineBreakMode:NSLineBreakByWordWrapping];
    float widthLabel  = textSize.width;
    float heightLabel = textSize.height;
    if (x1 > x2)
    {
        extra = -extra;
        xLabel = x2 - widthLabel/2;
        labelPoint.alignment = NSTextAlignmentRight;
    }
    else
    {
        xLabel = x2;
    }
    float yLabel = y2;
    float width = 50 - xLabel;//right - xLabel;
    if (x1 > x2)
    {
        width = xLabel - 50;
    }
   
    BOOL okBounds = false;
    while (!okBounds && line)
    {
        BOOL intersects = false;
        int length = prevLabelsBounds.count;
        for (int j = 0; j < length && !intersects; j++)
        {
            CGRect prevLabelBounds = [[prevLabelsBounds objectAtIndex:j] CGRectValue];
            CGRect rect = CGRectMake(xLabel, yLabel, widthLabel, heightLabel);
            if (CGRectIntersectsRect(prevLabelBounds,rect))
            {
                intersects = true;
                yLabel = MAX(yLabel, yLabel+ prevLabelBounds.size.height/3);
            }
        }
        okBounds = !intersects;
    }
    
    if (line)
    {
        y2 = (int) (yLabel - fontSize / 2);
        CGContextMoveToPoint(context, x1  , y1);
		CGContextAddLineToPoint(context, x2, y2);
        CGContextAddLineToPoint(context, x2 + extra, y2);
		CGContextStrokePath(context);
    }
    else
    {
        labelPoint.alignment = NSTextAlignmentCenter;
    }
    labelPoint.xLabel = xLabel;
    labelPoint.yLabel = yLabel;
    labelPoint.widthLabel = widthLabel;
    labelPoint.size = fontSize;
    labelPoint.heightLabel = heightLabel;
    return labelPoint;
}
- (void) clear
{
    [prevLabelsBounds removeAllObjects];
}
@end
