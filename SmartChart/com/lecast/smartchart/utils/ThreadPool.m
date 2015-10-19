//
//  ThreadPool.m
//  SmartChart
//
//  Created by Vincent.Niu on 13-5-23.
//  Copyright (c) 2013年 Lecast. All rights reserved.
//

#import "ThreadPool.h"

@implementation ThreadPool
- (void)runHandler
{
    dispatch_queue_t queue;
    queue = dispatch_queue_create("main_queue", NULL);
    queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^(void)
                  {
                      
                  });
    dispatch_async(queue, ^(void)
                   {
                       
                   });
   
    
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^(void)
    {
       // UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        //后台处理
        dispatch_sync(dispatch_get_main_queue(), ^(void)
        {
            //回到主线程更新ui
            //[[cell imageView] setImage:image];
           // [cell setNeedsLayout];
        });
    });
                       
}
                   
                   
                   
@end
