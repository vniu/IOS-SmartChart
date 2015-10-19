//
//  UIColor+ChartColor.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-24.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "UIColor+ChartColor.h"

@implementation UIColor (ChartColor)
+(UIColor*) randomColor
{
	srand(time(0));
	return [UIColor colorWithIndex:random()];
}
+(UIColor*) colorWithIndex:(int) index
{
    NSArray * commonColors=[NSArray arrayWithObjects:\
                            NEWCOLOR(0.816,0.906,0.976,1),\
                            NEWCOLOR(0.969,0.859,0.471,1),\
                            NEWCOLOR(0.737,0.835,0.427,1),\
                            NEWCOLOR(0.996,0.745,0.596,1),\
                            NEWCOLOR(0.435,0.749,0.753,1),\
                            NEWCOLOR(0.902,0.596,0.596,1),\
                            NEWCOLOR(0.741,0.596,0.737,1),\
                            NEWCOLOR(0.620,0.714,0.51,1),\
                            NEWCOLOR(0.992,0.969,0.663,1),\
                            NEWCOLOR(0.431,0.741,0.894,1),\
                            NEWCOLOR(0.776,0.443,0.894,1),\
                            NEWCOLOR(0.451,0.388,0.529,1),\
                            NEWCOLOR(0.784,0.875,0.937,1),\
                            NEWCOLOR(0.816,0.686,0.282,1),\
                            NEWCOLOR(0.671,0.773,0.345,1),\
                            NEWCOLOR(0.953,0.706,0.545,1),\
                            NEWCOLOR(0.361,0.678,0.682,1),\
                            NEWCOLOR(0.545,0.651,0.435,1),\
                            NEWCOLOR(0.780,0.435,0.431,1),\
                            nil];
	index = index < 0 ? 0 : index;
	index = index%([commonColors count]);
	return [UIColor colorWithCGColor:[[commonColors objectAtIndex:index] CGColor]];
}
-(UIColor*) lightColor:(CGFloat) scale
{
	CGColorRef colorRef = [self CGColor];
	int numComponents = CGColorGetNumberOfComponents(colorRef);
	if (numComponents == 4)
    {
		const CGFloat *components = CGColorGetComponents(colorRef);
		CGFloat R = components[0]+scale;
		CGFloat G = components[1]+scale;
		CGFloat B = components[2]+scale;
		return [UIColor colorWithRed:R green:G blue:B alpha:components[3]];
	}
	return nil;	
}


+ (UIColor *) colorFromHexCode:(NSString *)hexString
{
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3)
    {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6)
    {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *) turquoiseColor
{
    return [UIColor colorFromHexCode:@"1ABC9C"];
}

+ (UIColor *) greenSeaColor
{
    return [UIColor colorFromHexCode:@"16A085"];
}

+ (UIColor *) emerlandColor
{
    return [UIColor colorFromHexCode:@"2ECC71"];
}

+ (UIColor *) nephritisColor
{
    return [UIColor colorFromHexCode:@"27AE60"];
}

+ (UIColor *) peterRiverColor
{
    return [UIColor colorFromHexCode:@"3498DB"];
}

+ (UIColor *) belizeHoleColor
{
    return [UIColor colorFromHexCode:@"2980B9"];
}

+ (UIColor *) amethystColor
{
    return [UIColor colorFromHexCode:@"9B59B6"];
}

+ (UIColor *) wisteriaColor
{
    return [UIColor colorFromHexCode:@"8E44AD"];
}

+ (UIColor *) wetAsphaltColor
{
    return [UIColor colorFromHexCode:@"34495E"];
}

+ (UIColor *) midnightBlueColor
{
    return [UIColor colorFromHexCode:@"2C3E50"];
}

+ (UIColor *) sunflowerColor
{
    return [UIColor colorFromHexCode:@"F1C40F"];
}

+ (UIColor *) tangerineColor
{
    return [UIColor colorFromHexCode:@"F39C12"];
}

+ (UIColor *) carrotColor
{
    return [UIColor colorFromHexCode:@"E67E22"];
}

+ (UIColor *) pumpkinColor
{
    return [UIColor colorFromHexCode:@"D35400"];
}

+ (UIColor *) alizarinColor
{
    return [UIColor colorFromHexCode:@"E74C3C"];
}

+ (UIColor *) pomegranateColor
{
    return [UIColor colorFromHexCode:@"C0392B"];
}

+ (UIColor *) cloudsColor
{
    return [UIColor colorFromHexCode:@"ECF0F1"];
}

+ (UIColor *) silverColor
{
    return [UIColor colorFromHexCode:@"BDC3C7"];
}

+ (UIColor *) concreteColor
{
    return [UIColor colorFromHexCode:@"95A5A6"];
}

+ (UIColor *) asbestosColor
{
    return [UIColor colorFromHexCode:@"7F8C8D"];
}

+ (UIColor *) blendedColorWithForegroundColor:(UIColor *)foregroundColor
                              backgroundColor:(UIColor *)backgroundColor
                                 percentBlend:(CGFloat) percentBlend
{
    CGFloat onRed, offRed, newRed, onGreen, offGreen, newGreen, onBlue, offBlue, newBlue, onWhite, offWhite;
    if ([foregroundColor getWhite:&onWhite alpha:nil]) {
        onRed = onWhite;
        onBlue = onWhite;
        onGreen = onWhite;
    }
    else {
        [foregroundColor getRed:&onRed green:&onGreen blue:&onBlue alpha:nil];
    }
    if ([backgroundColor getWhite:&offWhite alpha:nil]) {
        offRed = offWhite;
        offBlue = offWhite;
        offGreen = offWhite;
    }
    else {
        [backgroundColor getRed:&offRed green:&offGreen blue:&offBlue alpha:nil];
    }
    newRed = onRed * percentBlend + offRed * (1-percentBlend);
    newGreen = onGreen * percentBlend + offGreen * (1-percentBlend);
    newBlue = onBlue * percentBlend + offBlue * (1-percentBlend);
    return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:1.0];
}


@end
