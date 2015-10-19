//
//  IAxis.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartesianChart.h"
#import "AxisLabelSetting.h"
@protocol IAxis <NSObject>
- (void) dataChanged;
- (void) update;
- (NSString *) getTitle;
- (NSString *) getDisplayName;
- (void) setDataProvider : (NSObject *) dataProvider;
- (void) setFontSize : (int) fontSize;
- (int) getTextAngle;
//- (void) accept: (CartesianChart*)chart;
- (AxisLabelSetting *) getAxisLabelSetting;
@end
