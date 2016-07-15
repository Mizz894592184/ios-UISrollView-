//
//  CirculateScrollView.m
//  UIScrollView循环
//
//  Created by mac on 16/7/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CirculateScrollView.h"

static int const ImageViewCount = 3;

@interface CirculateScrollView()<UIScrollViewDelegate>
@property(weak,nonatomic)UIScrollView * scrollView;
@property(weak,nonatomic)NSTimer * timer;

@end
@implementation CirculateScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //滚动视图
        UIScrollView * scrollView = [[UIScrollView alloc]init];
        
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        //图片控件
        for (int i = 0; i <ImageViewCount; i++) {
            UIImageView * imageView = [[UIImageView alloc]init];
            [scrollView addSubview:imageView];
        }
        //创建分页控件
        UIPageControl * pageControl = [[UIPageControl alloc]init];
        [self addSubview:pageControl];
        _pageControl = pageControl;
        
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    
    
    self.scrollView.contentSize = CGSizeMake(ImageViewCount * self.bounds.size.width, 0);
  
    
    for (int i = 0; i<ImageViewCount; i++) {
        UIImageView * imageView = self.scrollView.subviews[i];
        imageView.frame = CGRectMake(i*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        
    }
    
    CGFloat pageW = 80;
    CGFloat pageH = 20;
    CGFloat pageX = self.scrollView.frame.size.width - pageW;
    CGFloat pageY = self.scrollView.frame.size.height -pageH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
    
    
}

-(void)setImages:(NSArray *)images
{
    _images = images;
    
    //设置页码
    self.pageControl.numberOfPages= images.count;
    self.pageControl.currentPage = 0;
    NSLog(@"%@",_images[0]);
    
    //设置内容
    [self updateContent];
    //开始定时器
    [self startTimer];
}

#pragma mark -- <UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //找出最中间的那个图片控件
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    for (int i =0; i<self.scrollView.subviews.count; i++) {
        UIImageView * imageView = self.scrollView.subviews[i];
        CGFloat distance = 0;
        distance = ABS(imageView.frame.origin.x -scrollView.contentOffset.x);
        
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView .tag;
        }
    }
    self.pageControl.currentPage = page;
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateContent];
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateContent];
}
#pragma mark -- 内容更新
-(void)updateContent
{
    //设置图片
    for (int i = 0; i <self.scrollView.subviews.count; i++) {
        UIImageView * imageView = self.scrollView.subviews[i];
        NSInteger index = self.pageControl.currentPage;
        NSLog(@"%ld",index);
        if (i == 0) {
            index --;
        }else if (i==2){
            index++;
        }
        
        if (index <0) {
            index = self.pageControl.numberOfPages -1;
        }else if (index >= self.pageControl.numberOfPages)
        {
            index = 0;
        }
        
        imageView.tag= index;
        imageView.image = self.images[index];
        
    }
    
    
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    
    
}

#pragma mark -- 定时器
-(void)startTimer
{
    NSTimer * timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

-(void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
-(void)next
{
  
        [self.scrollView setContentOffset:CGPointMake(2*self.scrollView.frame.size.width, 0) animated:YES];
    
    
    
    
}


@end
