//
//  ViewController.m
//  LXScrollView
//
//  Created by 葡萄集 on 15/6/26.
//  Copyright (c) 2015年 LvXiongWei. All rights reserved.
//

#import "ViewController.h"
#import "LXScrollView.h"

@interface ViewController () <LXScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[@"pic1",@"pic2",@"pic3"];
    NSMutableArray *images = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
        
        UIImage *image = [UIImage imageNamed:name];
        [images addObject:image];
    }];
    
    LXScrollView *scrollView = [[LXScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) contentImages:images];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
}

- (void)touchPicAtIndex:(int)index
{
    NSLog(@"--点击了第%d张图片--",index);
}
@end
