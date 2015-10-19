//
//  LineLayer.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-22.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "BaseLayer.h"

@interface LineLayer : BaseLayer
{
    CGPoint startPoint;
    CGPoint endPoint;
    CGMutablePathRef linePath;
}
+ (LineLayer *)createLineLayer : (UIColor *)labelColor;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
- (void)drawPath : (CGPoint) mStartPoint endPoint : (CGPoint)mEndPoint;
@end
