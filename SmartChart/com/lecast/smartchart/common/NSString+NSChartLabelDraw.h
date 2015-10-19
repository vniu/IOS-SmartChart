//
//  NSString+NSChartLabelDraw.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-18.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (NSChartLabelDraw)
-(void)  drawWithBasePoint : (CGPoint)basePoint  andAngle : (CGFloat)angle andFont : (UIFont *)font;
@end
