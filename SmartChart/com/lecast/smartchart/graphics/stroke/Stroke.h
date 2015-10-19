//
//  Stroke.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-17.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
@interface Stroke : NSObject
{
    UIColor * strokeColor;
    UIColor * textColor;
    UIColor * fillColor;
}
@property (nonatomic, retain) UIColor * strokeColor;
@property (nonatomic, retain) UIColor * textColor;
@property (nonatomic, retain) UIColor * fillColor;
- (id) init : (UIColor *)mStrokeColor textColor : (UIColor *) mTextColor;
- (id) init : (UIColor *)mStrokeColor fillColor:(UIColor *)mFillColor;
@end

