//
//  CartesianSeries.h
//  SmartChart
//
//  Created byon 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Series.h"
#import "AxisBase.h"
#import "CategoryAxis.h"
#import "LinearAxis.h"
@interface CartesianSeries : Series
{
    int paddingLeft;
    int paddingBottom;
    int paddingTop;
    int paddingRight;
    AxisBase * verticalAxis;
    AxisBase * horizontalAxis;
    CategoryAxis * categoryAxis;
    LinearAxis * linearAxis;
    int seriesSize;
    int seriesIndex;
}
@property (nonatomic) int seriesSize;
@property (nonatomic) int seriesIndex;
@property(nonatomic) int paddingLeft;
@property(nonatomic) int paddingBottom;
@property(nonatomic) int paddingTop;
@property(nonatomic) int paddingRight;
@property(nonatomic, retain) AxisBase * verticalAxis;
@property(nonatomic, retain) AxisBase * horizontalAxis;

- (void) setPadding : (int) mPaddingLeft paddingTop : (int)mPaddingTop paddingBottom : (int)mPaddingBottom paddingRight : (int)mPaddingRight;
- (void) convertAxisClass;
- (void) addClickPoint : (int) index point : (CGPoint)touchPoint;
- (CGRect) getClickRect : (CGPoint)touchPoint;

@end
