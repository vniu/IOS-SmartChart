//
//  Line.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-21.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Shape.h"

@interface Line : Shape<IShape>
{
    CGPoint startPoint;
    CGPoint endPoint;
}
- (id)initWithPoint : (CGPoint)mStartPoint endPoint : (CGPoint)mEndPoint;
- (id)initWithPoint : (CGPoint)mStartPoint endPoint : (CGPoint)mEndPoint strokeColor : (UIColor *)strokeColor;
@end
