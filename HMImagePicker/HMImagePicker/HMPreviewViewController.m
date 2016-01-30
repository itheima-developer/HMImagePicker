//
//  HMPreviewViewController.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/29.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMPreviewViewController.h"
#import "HMImagePickerGlobal.h"
#import "HMViewerViewController.h"
#import "HMSelectCounterButton.h"
#import "HMImageSelectButton.h"

@interface HMPreviewViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic, readonly) NSInteger imagesCount;
/// 选择图像按钮
@property (nonatomic) HMImageSelectButton *selectedButton;
@end

@implementation HMPreviewViewController {
    UIPageViewController *_pageController;
    
    /// 相册模型
    HMAlbum *_album;
    /// 选中素材数组
    NSMutableArray <PHAsset *>*_selectedAssets;
    /// 选中素材索引
    NSMutableArray <NSNumber *>*_selectedIndexes;
    /// 最大选择图像数量
    NSInteger _maxPickerCount;
    /// 预览相册
    BOOL _previewAlbum;
    
    /// 完成按钮
    UIBarButtonItem *_doneItem;
    /// 选择计数按钮
    HMSelectCounterButton *_counterButton;
}

- (instancetype)initWithAlbum:(id)album
               selectedAssets:(NSMutableArray<PHAsset *> *)selectedAssets
               maxPickerCount:(NSInteger)maxPickerCount
                 previewAlbum:(BOOL)previewAlbum {
    
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _album = album;
        _selectedAssets = selectedAssets;
        _maxPickerCount = maxPickerCount;
        _previewAlbum = previewAlbum;
        
        // 记录选中素材索引
        _selectedIndexes = [NSMutableArray array];
        if (_previewAlbum) {
            for (NSInteger i = 0; i < _album.count; i++) {
                [_selectedIndexes addObject:@(NO)];
            }
            
        } else {
            for (NSInteger i = 0; i < _selectedAssets.count; i++) {
                [_selectedIndexes addObject:@(YES)];
            }
        }
    }
    return self;
}

- (NSInteger)imagesCount {
    if (_previewAlbum) {
        return _album.count;
    } else {
        return _selectedAssets.count;
    }
}

- (PHAsset *)assetWithIndex:(NSInteger)index {
    if (_previewAlbum) {
        return [_album assetWithIndex:index];
    } else {
        return _selectedAssets[index];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self prepareChildControllers];
    [self prepareNavigationBar];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // TODO: --- 更新选中资源数组
    //    for (NSInteger i = 0; i < _selectedIndexes.count; i++) {
    //        BOOL selected = _selectedIndexes[i].boolValue;
    //
    //        if (!selected) {
    //            [_selectedAssets removeObjectAtIndex:i];
    //        }
    //    }
    
    NSLog(@"%@", _selectedAssets);
}

#pragma mark - 监听方法
- (void)clickSelectedButton:(HMImageSelectButton *)button {
    HMViewerViewController *viewer = _pageController.viewControllers.lastObject;
    
    _selectedIndexes[viewer.index] = @(button.selected);
    
    NSLog(@"%@", _selectedIndexes);
}

// 如果没有选中照片，返回当前预览的图片
- (void)clickFinishedButton {
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:HMImagePickerDidSelectedNotification
     object:self
     userInfo:@{HMImagePickerDidSelectedAssetsKey: _selectedAssets}];
}

- (void)clickCloseButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    HMViewerViewController *viewer = (HMViewerViewController *)pendingViewControllers.lastObject;
    
    self.selectedButton.selected = _selectedIndexes[viewer.index].boolValue;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    HMViewerViewController *viewer = _pageController.viewControllers.lastObject;
    
    self.selectedButton.selected = _selectedIndexes[viewer.index].boolValue;
}

#pragma mark - UIPageViewControllerDataSource
/// 返回前一页控制器
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    return [self viewerControllerWithViewController:viewController isNext:NO];
}

/// 返回下一页控制器
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    return [self viewerControllerWithViewController:viewController isNext:YES];
}

- (nullable UIViewController *)viewerControllerWithViewController:(UIViewController *)viewController isNext:(BOOL)isNext {
    
    HMViewerViewController *detail = (HMViewerViewController *)viewController;
    NSInteger index = detail.index;
    
    index += isNext ? 1 : -1;
    
    if (index < 0 || index >= self.imagesCount) {
        return nil;
    }
    
    return [self viewerControllerWithIndex:index];
}

- (HMViewerViewController *)viewerControllerWithIndex:(NSInteger)index {
    HMViewerViewController *viewer = [[HMViewerViewController alloc] init];
    
    viewer.index = index;
    viewer.asset = [self assetWithIndex:index];
    
    return viewer;
}

#pragma mark - 准备子控制器
- (void)prepareChildControllers {
    
    NSDictionary *options = @{UIPageViewControllerOptionInterPageSpacingKey: @(20)};
    // 实例化分页控制器 - 水平分页滚动
    _pageController = [[UIPageViewController alloc]
                       initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                       navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                       options:options];
    
    NSArray *viewControllers = @[[self viewerControllerWithIndex:0]];
    self.selectedButton.selected = _selectedIndexes[0].boolValue;
    
    // 添加分页控制器的子视图控制器数组
    [_pageController setViewControllers:viewControllers
                              direction:UIPageViewControllerNavigationDirectionForward
                               animated:NO
                             completion:nil];
    
    [self addChildViewController:_pageController];
    [self.view addSubview:_pageController.view];
    
    [_pageController didMoveToParentViewController:self];
    
    self.view.gestureRecognizers = _pageController.gestureRecognizers;
    
    _pageController.dataSource = self;
    _pageController.delegate = self;
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
    
    _counterButton.count = _selectedAssets.count;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.selectedButton];
}

#pragma mark - 懒加载
- (HMImageSelectButton *)selectedButton {
    if (_selectedButton == nil) {
        _selectedButton = [[HMImageSelectButton alloc]
                           initWithImageName:@"check_box_default"
                           selectedName:@"check_box_right"];
        [_selectedButton addTarget:self action:@selector(clickSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedButton;
}

@end
