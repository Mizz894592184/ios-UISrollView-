//
//  ViewController.m
//  UIScrollView循环
//
//  Created by mac on 16/7/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "CirculateScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化对象
    CirculateScrollView *  scrollView = [[CirculateScrollView alloc]init];
    //设置滚动视图的大小
    scrollView.frame = CGRectMake(0, 20, self.view.frame.size.width, 200);
    //设置循环滚动的图片
    scrollView.images = @[
                          [UIImage imageNamed:@"1"],
                          [UIImage imageNamed:@"2"],
                          [UIImage imageNamed:@"3"],
                          [UIImage imageNamed:@"4"],
                          [UIImage imageNamed:@"5"]
                          ];
    //设置页面指示器的颜色
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    scrollView.pageControl .pageIndicatorTintColor = [UIColor grayColor];
    //添加到当前view
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
