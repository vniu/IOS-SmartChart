//
//  ICAlayer.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-24.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ICALayer <NSObject>
@optional
- (void) setPropertyHandler : (CGFloat)mLeft height : (CGFloat)mHeight rectWidth : (CGFloat)mRectWidth bottom : (CGFloat)mBottom;
- (void) setValueHandler : (CGFloat) mValue;
- (CGFloat) getValueHandler;
- (void) createAnimationForKey:(NSString *)key fromValue:(NSNumber *)from toValue:(NSNumber *)to delegate:(id)delegate;
- (void) setFrameHandler : (CGRect)mFrame;
- (void) setSeriesIndex : (CGFloat)index;
- (CGFloat) getSeriesIndex ;
@end
