//
//  ChartModel.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-7-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AxisModel.h"
#import "SeriesModel.h"

@interface ChartModel : NSObject
{
    NSString * name;
    NSMutableArray * seriesModels;
    int paddingLeft;
    int paddingRight;
    int paddingTop;
    int paddingBottom;
    NSString * chartLegendName;
    AxisModel * horizonalAxisModel;
    AxisModel * verticalAxisModel;
    int fontSize;
    int radius;
    NSString * titleName;
    AxisModel * dialAxisModel;
    int titleColor;
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSMutableArray * seriesModels;
@property (nonatomic) int paddingLeft;
@property (nonatomic) int paddingRight;
@property (nonatomic) int paddingTop;
@property (nonatomic) int paddingBottom;
@property (nonatomic, retain) NSString * chartLegendName;
@property (nonatomic, retain) AxisModel * horizonalAxisModel;
@property (nonatomic, retain) AxisModel * verticalAxisModel;
@property (nonatomic) int fontSize;
@property (nonatomic) int radius;
@property (nonatomic, retain) NSString * titleName;
@property (nonatomic) AxisModel * dialAxisModel;
@property (nonatomic) int titleColor;

- (void) addSeriesModel:(SeriesModel * )seriesModel;

@end
