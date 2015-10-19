//
//  PointMapping.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "PointMapping.h"

@implementation PointMapping

-(id)init
{
    self = [super init];
    if(self)
    {
        points = [[NSMutableArray alloc] init];
    }
    return  self;
}

-(void)addPoint:(LocalPoint *) point
{
    if ([points containsObject:point])
    {
        return;
    }
    [points addObject:point];
}

- (void)clear
{
    [points removeAllObjects];
}

-(LocalPoint *) getClickPoint :(LocalPoint *) mScreenPoint
{
    for (LocalPoint * point in points)
    {
        if (CGRectContainsPoint(point.rect,  CGPointMake(mScreenPoint.x, mScreenPoint.y)))
        {
            return point;
        }
    }
    return  nil;
}

@end
