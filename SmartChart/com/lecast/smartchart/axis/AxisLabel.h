//
//  AxisLabel.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-4.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AxisLabel : NSObject
{
    double position;
    NSObject * value;
    NSString * text;
}
@property (nonatomic)double position;
@property (nonatomic)id value;
@property (nonatomic, retain)NSString * text;

- (id)init : (double)index value : (NSObject *)valueObj text : (NSString *)textStr;
@end
