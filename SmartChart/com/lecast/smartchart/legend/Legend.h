//
//  Legend.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Series.h"
@class ChartBase;

@interface Legend : NSObject
{
    ChartBase * chart;
    CGFloat size;
    CGFloat fontSize;
    CGFloat x;
    CGFloat y;
    UIView * view;
    UIColor * legendColor;
}
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) CGFloat size;
@property (nonatomic, retain) ChartBase * chart;
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic, retain) UIView * view;

- (void) executeDrawHandler : (CGContextRef) context;
- (void) drawLegendHandler : (CGContextRef) context displayName : (NSString *) name;
- (BOOL) drawPieLegend : (CGContextRef) context series : (Series *) series;

@end
