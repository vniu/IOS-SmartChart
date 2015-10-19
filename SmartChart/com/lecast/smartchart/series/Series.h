//
//  Series.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISeries.h"
#import "PointMapping.h"
#import "Stroke.h"
@interface Series : NSOperation<ISeries>
{
    NSMutableArray * shapeLayers;
    Stroke *stroke;
    NSString * valueField;
    NSMutableArray * dataProvider;
    BOOL isJsonFormat;
    PointMapping * pointMapping;
    int fontSize;

    NSString * displayName;
    float offsetX;
    float offsetY;
    int scale;
    int dataSize;
    NSMutableArray * propertyValues;
    UIColor * labelColor;
    CGContextRef context;
    UIView * chartView;
    NSTimer * animationTimer;
    NSMutableArray * animations;
}
@property (nonatomic, retain) NSMutableArray * shapeLayers;
@property (nonatomic, retain) Stroke * stroke;
@property (nonatomic, retain) NSString * valueField;
@property (nonatomic, retain) NSMutableArray * dataProvider;
@property (nonatomic, retain) PointMapping * pointMapping;
@property (nonatomic, retain) NSString * displayName;
@property (nonatomic) int fontSize;
@property (nonatomic) float offsetX;
@property (nonatomic) float offsetY;
@property (nonatomic) int scale;
@property (nonatomic) int dataSize;
@property (nonatomic, retain) UIColor * labelColor;
@property (nonatomic, retain) NSMutableArray * propertyValues;
@property (nonatomic) CGContextRef context;
@property (nonatomic, retain) UIView * chartView;
- (void) setOffset : (float) mOffsetX offsetY : (float) mOffsetY;
- (void) filterValueHandler;
- (void) setDataProviderHandler : (NSMutableArray *) mDataProvider;
- (void) initGraphicsContext : (CGContextRef)mContext;

-(void) updateOnStopHandler;

//- (void)drawInContext;
//- (void) drawTextInContext  : (NSString *)text x : (CGFloat)x y : (CGFloat)y;
@end
