//
//  HMPreviewViewController.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/29.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMPreviewViewController.h"
#import "HMViewerViewController.h"
#import "HMSelectCounterButton.h"

@interface HMPreviewViewController ()

@end

@implementation HMPreviewViewController {
    UIPageViewController *_pageController;
    
    /// 相册模型
    HMAlbum *_album;
    /// 选中素材数组
    NSMutableArray <PHAsset *>*_selectedAssets;
    /// 最大选择图像数量
    NSInteger _maxPickerCount;
    
    /// 完成按钮
    UIBarButtonItem *_doneItem;
    /// 选择计数按钮
    HMSelectCounterButton *_counterButton;
}

- (instancetype)initWithAlbum:(id)album selectedAssets:(NSMutableArray<PHAsset *> *)selectedAssets maxPickerCount:(NSInteger)maxPickerCount {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _album = album;
        _selectedAssets = selectedAssets;
        _maxPickerCount = maxPickerCount;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self prepareChildControllers];
    [self prepareNavigationBar];
}

#pragma mark - 监听方法
// 如果没有选中照片，返回当前预览的图片
- (void)clickFinishedButton {
    
    //    [[NSNotificationCenter defaultCenter]
    //     postNotificationName:HMImagePickerDidSelectedNotification
    //     object:self
    //     userInfo:@{HMImagePickerDidSelectedAssetsKey: _selectedAssets}];
    NSLog(@"%s", __FUNCTION__);
}

- (void)clickCloseButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 准备子控制器
- (void)prepareChildControllers {
    
    // 实例化分页控制器 - 水平分页滚动
    _pageController = [[UIPageViewController alloc]
                       initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                       navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                       options:nil];
    
    HMViewerViewController *viewer = [[HMViewerViewController alloc] init];
    viewer.index = 0;
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

/// 准备导航栏
- (void)prepareNavigationBar {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.navigationController.hidesBarsOnTap = YES;
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clickCloseButton)];
    
    _counterButton = [[HMSelectCounterButton alloc] init];
    UIBarButtonItem *counterItem = [[UIBarButtonItem alloc] initWithCustomView:_counterButton];
    
    _doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(clickFinishedButton)];
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.toolbarItems = @[cancelItem, spaceItem, counterItem, _doneItem];
}

@end
