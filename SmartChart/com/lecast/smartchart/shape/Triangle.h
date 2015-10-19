//
//  Triangle.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-17.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Shape.h"

@interface Triangle : Shape<IShape>
{
    CGMutablePathRef pathRef;
}

- (void) drawTriangleHandler : (CGPoint) point;
@end
