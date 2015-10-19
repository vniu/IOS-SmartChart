//
//  SeriesVO.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-27.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Series.h"
@interface SeriesModel : NSObject
{
    NSString * valueField;
    NSString * color;
    NSString * name;
    NSString * displayName;
    int strokeWidth;
    NSString * labelField;
    NSString * suffixName;
}

@property (nonatomic, retain) NSString * valueField;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * color;
@property (nonatomic) int strokeWidth;
@property (nonatomic, retain) NSString * displayName;
@property (nonatomic, retain) NSString * labelField;
@property (nonatomic, retain) NSString * suffixName;

- (Series *) getSeries;

@end
