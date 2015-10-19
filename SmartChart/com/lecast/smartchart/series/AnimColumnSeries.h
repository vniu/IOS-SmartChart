//
//  AnimColumnSeries.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-23.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "ColumnSeries.h"
#import "ICALayer.h"
@interface AnimColumnSeries : ColumnSeries
{
    NSInteger diff;
    BOOL enableGradient;
    NSMutableArray * localLayers;
    BOOL isVerticalGradient;
}
@property (nonatomic) BOOL enableGradient;
- (id<ICALayer>)createLayer : (int) index value : (CGFloat) value  layersToRemove : (NSMutableArray *)layersToRemove;
- (void) getLayerByIndex;
@end
