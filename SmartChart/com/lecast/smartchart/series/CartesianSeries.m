//
//  CartesianSeries.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-6-8.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "CartesianSeries.h"
#import "LocalPoint.h"
@implementation CartesianSeries

@synthesize paddingLeft;
@synthesize paddingTop;
@synthesize paddingRight;
@synthesize paddingBottom;
@synthesize verticalAxis;
@synthesize horizontalAxis;
@synthesize seriesIndex;
@synthesize seriesSize;
- (void) setPadding : (int) mPaddingLeft paddingTop : (int)mPaddingTop paddingBottom : (int)mPaddingBottom paddingRight : (int)mPaddingRight
{
    paddingBottom = mPaddingBottom;
    paddingLeft = mPaddingLeft;
    paddingRight = mPaddingRight;
    paddingTop = mPaddingTop;
}
- (void) onDrawHandler : (UIView*)view
{
    [self convertAxisClass];
}
- (void) convertAxisClass
{
    if ([verticalAxis isKindOfClass:[LinearAxis class]])
    {
        linearAxis =(LinearAxis *) verticalAxis;
    }
    else
    {
        categoryAxis = (CategoryAxis *)verticalAxis;
    }
    
    if ([horizontalAxis isKindOfClass:[CategoryAxis class]])
    {
        categoryAxis =(CategoryAxis *) horizontalAxis;
    }
    else
    {
        linearAxis = (LinearAxis *)horizontalAxis;
    }
}
- (void) addClickPoint : (int) index point : (CGPoint)touchPoint
{
    NSObject * object = [dataProvider objectAtIndex:index];
    LocalPoint * localPoint = [[LocalPoint alloc] init];
    localPoint.x = touchPoint.x;
    localPoint.y = touchPoint.y;
    localPoint.value = object;
    localPoint.rect = [self getClickRect:touchPoint];
    [pointMapping addPoint:localPoint];
}

- (CGRect) getClickRect : (CGPoint)touchPoint
{
    float scaleFactor = 15;
    int left = (int) (touchPoint.x - scaleFactor);
    int top = (int) (touchPoint.y - scaleFactor);
    return  CGRectMake(left, top, scaleFactor * 2, 2 * scaleFactor);
}



@end
