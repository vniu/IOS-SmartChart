//
//  Shape.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-21.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
//@protocol IShape;
#import <UIKit/UIKit.h>
@interface Shape : NSObject
{
    UIColor * fillColor;
    UIColor * strokeColor;
    CGFloat lineWidth;
    CGAffineTransform transform;
    NSMutableArray * gradients;
}
@property(nonatomic, retain) UIColor * fillColor;
@property(nonatomic, retain) UIColor * strokeColor;
@property(nonatomic) CGFloat lineWidth;
@property(nonatomic) CGAffineTransform transform;
@property(nonatomic) NSMutableArray * gradients;


-(id) initWithLineWidth : (float) width;
-(id) initWithStrokeColor : (UIColor *)color;
-(id) initWithFillColor : (UIColor *) color;
-(id) initWithStrokeColor : (UIColor *)mStrokeColor fillColor : (UIColor *)fcolor;
-(id) initWithStrokeColor : (UIColor *)mStrokeColor fillColor : (UIColor *)fcolor lineWidth : (float) width;
@end

@interface  Shape(private)
-(BOOL) initContext : (CGContextRef) context;
-(void) drawFinish:(CGContextRef) context;
-(void) fillStrokePath : (CGContextRef) context pathRef : (CGMutablePathRef) pathRef;

@end

@protocol IShape <NSObject>
- (void)drawHandler : (CGContextRef) context;
@end