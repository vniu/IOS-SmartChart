//
//  RoundSeries.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Series.h"
#import <QuartzCore/QuartzCore.h>
@interface RoundSeries : Series
{
    float centerX;
    float centerY;
    NSString * labelField;
    NSMutableArray * colorsCache;
    NSString * suffixName;
    float radius;
    BOOL showLabel;
}
@property (nonatomic) float radius;
@property (nonatomic, retain) NSString * labelField;
@property (nonatomic) BOOL showLabel;
@property (nonatomic, retain) NSString * suffixName;
- (void) generateColors; 
- (void) setCenterHandler : (float)mLastCenterX lastCenterY : (float)mLastCenterY  lastRadius : (float)mLastRadius;
- (void) addClickPoint : (int)index angle : (float)angle;
- (NSString *) getCategoryName : (int) index;
- (NSMutableArray *) getCacheColors;
@end
