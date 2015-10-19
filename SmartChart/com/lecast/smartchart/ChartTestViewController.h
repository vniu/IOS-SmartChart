//
//  ChartTestViewController.h
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-17.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartTestViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView * chartTableView;
    NSMutableArray * dataSources;
}
- (void) initData;
@end
