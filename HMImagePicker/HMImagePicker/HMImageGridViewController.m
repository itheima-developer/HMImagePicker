//
//  HMImageGridViewController.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMImageGridViewController.h"
#import "HMAlbum.h"
#import "HMImageGridCell.h"
#import "HMImageGridViewLayout.h"
#import "HMSelectCounterButton.h"

static NSString *const HMImageGridViewCellIdentifier = @"HMImageGridViewCellIdentifier";

@interface HMImageGridViewController () <HMImageGridCellDelegate>

@end

@implementation HMImageGridViewController {
    /// 相册模型
    HMAlbum *_album;
    /// 预览按钮
    UIBarButtonItem *_previewItem;
    /// 完成按钮
    UIBarButtonItem *_doneItem;
    /// 选择计数按钮
    HMSelectCounterButton *_counterButton;
}

#pragma mark - 构造函数

- (instancetype)initWithAlbum:(HMAlbum *)album {
    HMImageGridViewLayout *layout = [[HMImageGridViewLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        _album = album;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
}

#pragma mark - HMImageGridCellDelegate
- (void)imageGridCell:(HMImageGridCell *)cell didSelected:(BOOL)selected {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    PHAsset *asset = [_album assetWithIndex:indexPath.item];
    
    if (selected) {
        [self.selectedAssets addObject:asset];
    } else {
        [self.selectedAssets removeObject:asset];
    }
    
    // 更新 UI
    _counterButton.count = self.selectedAssets.count;
    _doneItem.enabled = _counterButton.count > 0;
    _previewItem.enabled = _counterButton.count > 0;
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _album.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HMImageGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HMImageGridViewCellIdentifier forIndexPath:indexPath];
    
    cell.imageView.image = [_album emptyImageWithSize:cell.bounds.size];
    [_album requestThumbnailWithAssetIndex:indexPath.item Size:cell.bounds.size completion:^(UIImage * _Nonnull thumbnail) {
        cell.imageView.image = thumbnail;
    }];
    
    cell.delegate = self;
    
    return cell;
}

#pragma mark - 监听方法
- (void)clickPreviewButton {
    NSLog(@"%s", __FUNCTION__);
}

- (void)clickFinishedButton {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - 设置界面
- (void)prepareUI {
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.title = _album.title;
    
    // 工具条
    _previewItem = [[UIBarButtonItem alloc] initWithTitle:@"预览" style:UIBarButtonItemStylePlain target:self action:@selector(clickPreviewButton)];
    _previewItem.enabled = NO;
    
    _counterButton = [[HMSelectCounterButton alloc] init];
    UIBarButtonItem *counterItem = [[UIBarButtonItem alloc] initWithCustomView:_counterButton];
    
    _doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(clickFinishedButton)];
    _doneItem.enabled = NO;
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.toolbarItems = @[_previewItem, spaceItem, counterItem, _doneItem];
    
    // 注册可重用 cell
    [self.collectionView registerClass:[HMImageGridCell class] forCellWithReuseIdentifier:HMImageGridViewCellIdentifier];
}

@end
