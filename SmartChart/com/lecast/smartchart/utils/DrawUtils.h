//
//  DrawUtils.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DrawUtils : NSObject
+ (UIColor *) getRandomColor;
+ (CGSize) getTextRect : (NSString *)textValue fontSize : (float)fontSize;
+ (void) drawText : (NSString *)text point : (CGPoint)point fontSize : (float)fontSize;
+ (void) drawTextOnDegrees : (CGContextRef)context text: (NSString *)labelText point : (CGPoint)point fontSize : (float)fontSize degrees : (float)degrees;
+ (CGPoint) getCirclePoint: (CGPoint) certer radius : (CGFloat) radius angle : (CGFloat) angle;
@end
