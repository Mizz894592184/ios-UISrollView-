//
//  CirculateScrollView.h
//  UIScrollView循环
//
//  Created by mac on 16/7/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CirculateScrollView : UIView

@property(strong,nonatomic)NSArray *images;
@property(weak,nonatomic,readonly) UIPageControl *pageControl;


@end
