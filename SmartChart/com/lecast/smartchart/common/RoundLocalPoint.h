//
//  RoundLocalPoint.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "LocalPoint.h"

@interface RoundLocalPoint : LocalPoint
{
    float angle;
}
@property (nonatomic)float angle;

- (id) init : (float)angle value : (NSObject *)value;
@end
