//
//  Diamon.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-17.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Shape.h"

@interface Diamon : Shape<IShape>
{
    CGMutablePathRef pathRef;
}

- (void) drawDiamonHandler : (CGPoint) point;
@end
