//
//  SeriesCreator.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-7-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeriesModel.h"
@interface SeriesCreator : NSObject

+ (Series *) getSeries : (SeriesModel * )seriesModel;
@end
