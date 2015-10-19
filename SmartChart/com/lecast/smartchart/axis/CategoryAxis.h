//
//  CategoryAxis.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "AxisBase.h"

@interface CategoryAxis : AxisBase
{
    NSString * categoryField;
}
@property (nonatomic, retain) NSString * categoryField;
- (void) onDataProviderHandler : (NSString *)suffixStr;
@end
