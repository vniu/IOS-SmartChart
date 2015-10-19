//
//  RoundPointMapping.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "RoundPointMapping.h"
#import <GLKit/GLKMath.h>
#import "RoundLocalPoint.h"
@implementation RoundPointMapping
@synthesize centerX;
@synthesize centerY;
@synthesize radius;


- (double) getAngel : (LocalPoint *) screenPoint
{
    double dx = screenPoint.x - centerX;
    double dy = -(screenPoint.y - centerY);
    double inRads = atan2(dy, dx);
    inRads = inRads < 0 ? abs(inRads) : 2*M_PI  - inRads;
    return GLKMathRadiansToDegrees(inRads);
}

//float bearingDegrees = inRads * (180.0 / M_PI); // convert to degrees
//bearingDegrees = (bearingDegrees > 0.0 ? bearingDegrees : (360.0 + bearingDegrees)); // correct discontinuity
//return bearingDegrees;

- (void) setCenterHandler : (float)mCenterX centerY : (float)mCenterY
{
    centerY = mCenterY;
    centerX = mCenterX;
}
- (int) getEventAngle : (LocalPoint *) screenPoint
{
    double x = screenPoint.x - centerX;
    double y = screenPoint.y - centerY; 
    double z = hypot(abs(x), abs(y)); 
    double sinA = (double) abs(y) / z;
    double asinV = asin(sinA); 
    int degree = (int) (asinV / 3.14f * 180);
    int realDegree = 0;
    if (x <= 0 && y <= 0)
    {
        realDegree = 180 + degree;
    }
    else if (x >= 0 && y <= 0)
    {
        realDegree = 360 - degree;
    }
    else if (x <= 0 && y >= 0)
    {
        realDegree = 180 - degree;
    }
    else
    {
        realDegree = degree;
    }
    return realDegree;
}

- (BOOL) isOnRoundChart : (LocalPoint *) screenPoint
{
    double sqValue = (pow(centerX - screenPoint.x, 2) + pow(centerY - screenPoint.y, 2));
    double radiusSquared = radius * radius;
    BOOL isOnPieChart = sqValue <= radiusSquared;
    return isOnPieChart;
}

- (LocalPoint *) getClickPoint : (LocalPoint *)screenPoint
{
    if ([self isOnRoundChart: screenPoint])
    {
        double angleFromRoundCenter = [self getEventAngle : screenPoint];
        int currentSum = 0;
        for (LocalPoint *point in points)
        {
            RoundLocalPoint *roundPoint = (RoundLocalPoint*) point;
            currentSum += roundPoint.angle;
            if (currentSum >= angleFromRoundCenter)
            {
                return roundPoint;
            }
        }
    }
    return nil;
}

@end
