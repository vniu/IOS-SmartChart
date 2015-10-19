//
//  GridLine.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stroke.h"
@interface GridLine : NSObject
{
    CGContextRef context;
    Stroke * lineStroke;
    
}
@property(nonatomic, retain) Stroke * lineStroke;
- init : (CGContextRef)context;
- (void) drawGridLine : (CGPoint)startPoint endPoint : (CGPoint) endPoint;
- (void) drawLine : (CGPoint)startPoint endPoint : (CGPoint) endPoint lineWidth : (NSInteger)mLineWidth;
@end
