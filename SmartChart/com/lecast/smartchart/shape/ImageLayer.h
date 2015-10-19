//
//  ImageLayer.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-5.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImageLayer : NSObject
{
    CGContextRef context;
    CGSize layerSize;
    CGRect imageRect;
    CGPoint drawPoint;
}

@property (nonatomic) CGRect imageRect;
@property (nonatomic) CGPoint drawPoint;
- (id) init : (CGContextRef) ctx layerSize : (CGSize)mLayerSize;
- (void) drawImageOnLayer : (UIImage *) image degree : (CGFloat)angle;
@end
