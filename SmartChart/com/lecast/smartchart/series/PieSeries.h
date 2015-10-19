//
//  PieSeries.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "RoundSeries.h"
#import "SliceLayer.h"
#import "RoundLabelDrawer.h"
@interface PieSeries : RoundSeries
{
    CGFloat selectedSliceOffsetRadius;
    UIView * pieView;
    BOOL showPercentage;
    int selectedSliceIndex;
    NSMutableArray * labelBounds;
    RoundLabelDrawer * labelDrawer;
    NSMutableArray * labels;
}
@property (nonatomic)BOOL showPercentage;
@property (nonatomic)BOOL showLabel;
@property (nonatomic)int selectedSliceIndex;
@property (nonatomic, retain) NSMutableArray * labels;
- (void)updateLabelForLayer : (SliceLayer *)pieLayer value : (CGFloat)value;
- (void)setSliceSelectedAtIndex : (NSInteger)index ;
- (void)setSliceDeselectedAtIndex : (NSInteger)index ;
- (void)notifySelectionChangeFrom : (NSUInteger)previousSelection to : (NSUInteger)newSelection;
@end
