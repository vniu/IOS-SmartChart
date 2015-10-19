//
//  Area.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-7.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Shape.h"

@interface Area : Shape<IShape>
{
    CGMutablePathRef pathRef;
    
}

@property (nonatomic) CGMutablePathRef pathRef;

- (void) moveToPoint : (CGPoint) point;
- (void) addLineToPoint : (CGPoint) point;
@end
