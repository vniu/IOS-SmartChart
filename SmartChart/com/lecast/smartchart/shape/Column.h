//
//  Column.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-21.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "Shape.h"

@interface Column : Shape<IShape>
{
    CGMutablePathRef pathRef;
    CGRect rect;
    BOOL isVertical;
}
@property (nonatomic) BOOL isVertical;
- (id) init : (CGRect) mRect;
@end
