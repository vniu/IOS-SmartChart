//
//  SliceLayer.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-17.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BaseLayer.h"
@interface SliceLayer : BaseLayer
{

    CGFloat percentage;
}
@property (nonatomic, assign) CGFloat percentage;
+ (SliceLayer *)createSliceLayer : (UIColor *)labelColor centerPoint : (CGPoint)pieCenter;
@end
