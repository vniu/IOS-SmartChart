//
//  UIColor+ChartColor.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-24.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NEWCOLOR(r,g,b,a) [UIColor colorWithRed:r green:g blue:b alpha:a]

@interface UIColor (ChartColor)

+ (UIColor *) colorFromHexCode:(NSString *)hexString;
+ (UIColor*) randomColor;
+ (UIColor*) colorWithIndex:(int) index;
- (UIColor*) lightColor:(CGFloat) scale;
+ (UIColor *) turquoiseColor;
+ (UIColor *) greenSeaColor;
+ (UIColor *) emerlandColor;
+ (UIColor *) nephritisColor;
+ (UIColor *) peterRiverColor;
+ (UIColor *) belizeHoleColor;
+ (UIColor *) amethystColor;
+ (UIColor *) wisteriaColor;
+ (UIColor *) wetAsphaltColor;
+ (UIColor *) midnightBlueColor;
+ (UIColor *) sunflowerColor;
+ (UIColor *) tangerineColor;
+ (UIColor *) carrotColor;
+ (UIColor *) pumpkinColor;
+ (UIColor *) alizarinColor;
+ (UIColor *) pomegranateColor;
+ (UIColor *) cloudsColor;
+ (UIColor *) silverColor;
+ (UIColor *) concreteColor;
+ (UIColor *) asbestosColor;
+ (UIColor *) blendedColorWithForegroundColor:(UIColor *)foregroundColor
                              backgroundColor:(UIColor *)backgroundColor
                                 percentBlend:(CGFloat) percentBlend;


@end
