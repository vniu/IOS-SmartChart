//
//  ISeries.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol ISeries <NSObject>
- (void) onDrawHandler : (UIView *)view;
@optional
- (void) updateShapeHandler : (NSTimer *) timer;
@end
