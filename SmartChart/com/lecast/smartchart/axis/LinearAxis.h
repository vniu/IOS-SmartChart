//
//  LinearAxis.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "AxisBase.h"

@interface LinearAxis : AxisBase
{
    double minAxisValue;
    double maxAxisValue;
    int interval;
    NSMutableArray * valueFields;
    NSMutableArray * describeData;
    double labelMiniumn;
    int offset ;
    bool alignLabelsToInterval;
}
@property (nonatomic, retain) NSMutableArray * valueFields;
@property (nonatomic) int interval;
@property (nonatomic) double maxAxisValue;
- (void) generateLabels;
- (void) updateRange  : (double) y;
- (void) initRange ;
- (void) onDataProviderHandler;
- (void) resetInitValue;
@end
