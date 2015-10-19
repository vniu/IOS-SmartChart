//
//  RoundPointMapping.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "PointMapping.h"
#import "LocalPoint.h"
#define PI 3.14159265358979323846
@interface RoundPointMapping : PointMapping
{
    float centerX;
    float centerY;
    float radius;
}
@property(nonatomic)float centerX;
@property(nonatomic)float centerY;
@property(nonatomic)float radius;

- (double) getAngel : (LocalPoint *) screenPoint;
- (void) setCenterHandler:(float) mCenterX centerY : (float) mCenterY;
- (int) getEventAngle : (LocalPoint *) screenPoint;
- (BOOL) isOnRoundChart : (LocalPoint *) screenPoint;
- (LocalPoint *) getClickPoint : (LocalPoint *) screenPoint;

@end
