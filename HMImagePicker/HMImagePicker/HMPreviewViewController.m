//
//  HMPreviewViewController.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/29.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMPreviewViewController.h"
#import "HMViewerViewController.h"

@interface HMPreviewViewController ()

@end

@implementation HMPreviewViewController {
    UIPageViewController *_pageController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareChildControllers];
}

#pragma mark - 准备子控制器
- (void)prepareChildControllers {
    
    // 实例化分页控制器 - 水平分页滚动
    _pageController = [[UIPageViewController alloc]
                       initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                       navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                       options:nil];
    
    HMViewerViewController *viewer = [[HMViewerViewController alloc] init];
    NSArray *viewControllers = @[viewer];
    
    // 添加分页控制器的子视图控制器数组
    [_pageController setViewControllers:viewControllers
                              direction:UIPageViewControllerNavigationDirectionForward
                               animated:NO
                             completion:nil];
    
    [self addChildViewController:_pageController];
    [self.view addSubview:_pageController.view];
    
    [_pageController didMoveToParentViewController:self];
    
    self.view.gestureRecognizers = _pageController.gestureRecognizers;
}

@end
