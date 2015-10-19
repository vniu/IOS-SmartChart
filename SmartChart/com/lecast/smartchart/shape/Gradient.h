//
//  Gradient.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-5.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Gradient : NSObject
{
    CGContextRef context;
    CGRect rect;
    CGPoint startPoint;
    CGPoint endPoint;
    
}
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
- (id)init : (CGContextRef)mContext clip : (CGRect) mClip;
- (CGGradientRef) buildCGGradient : (NSMutableArray *) gradientColors;

@end

@protocol IGradientDraw <NSObject>
@optional
- (void) drawGradientHandler : (NSMutableArray *)gradientColors;
@end
