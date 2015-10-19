//
//  PointMapping.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocalPoint.h"

@interface PointMapping : NSObject
{
    NSMutableArray * points;
}
- (void)addPoint:(LocalPoint *) point;
- (LocalPoint *) getClickPoint :(LocalPoint *) point;
- (void)clear;
@end
