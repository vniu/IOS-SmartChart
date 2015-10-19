//
//  ChartBase.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AxisBase.h"
#import "ISeries.h"
#import "PointMapping.h"
@class Legend;
@interface ChartBase : NSObject
{
   
    NSMutableArray * mSeries;
    NSMutableArray * dataProvider;
    float scale;
    int paddingLeft;
    int paddingTop;
    int paddingBottom;
    int paddingRight;
    int fontSize;
    int offsetX;
    int offsetY;
    PointMapping * pointMapping;
    CGContextRef context;
    UIView * chartView;
    Legend * chartLegend;
    BOOL drawFinished ;
}
@property (nonatomic, retain) AxisBase * horizonAxis;
@property (nonatomic, retain) AxisBase * verticalAxis;
@property (nonatomic, retain) NSMutableArray * mSeries;
@property (nonatomic, retain) NSMutableArray * dataProvider;
@property (nonatomic, retain) PointMapping * pointMapping;
@property (nonatomic)float scale;
@property (nonatomic)int paddingLeft;
@property (nonatomic)int paddingTop;
@property (nonatomic)int paddingBottom;
@property (nonatomic)int paddingRight;
@property (nonatomic)int fontSize;
@property (nonatomic)int offsetX;
@property (nonatomic)int offsetY;
@property (nonatomic)CGContextRef context;
@property (nonatomic, retain) UIView * chartView;

@property (nonatomic, strong) Legend * chartLegend;

- (void) setPadding : (int) mPaddingLeft paddingTop : (int)mPaddingTop paddingBottom : (int)mPaddingBottom paddingRight : (int)mPaddingRight;
- (void) addSeries : (id<ISeries>)series;
- (void) drawSeriesHandler : (UIView *)view ;
- (void) onDraw : (UIView*)view;
- (LocalPoint *)  getPointForScreenCoordinate: (LocalPoint *) screenPoint;
- (void) restore;
- (void) setNeedsDisplay;
- (void) drawLegendHandler : (UIView *) view;

- (void) setDataProviderHandler : (NSMutableArray *)dataProvider;
@end
