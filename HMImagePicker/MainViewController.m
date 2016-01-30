//
//  MainViewController.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "MainViewController.h"
#import "HMImagePickerController.h"
#import "MainViewCell.h"

@interface MainViewController () <HMImagePickerControllerDelegate>
@property (nonatomic) NSArray *images;
@property (nonatomic) NSArray *selectedAssets;
@end

@implementation MainViewController

- (IBAction)clickSelectPhotoButton {
    HMImagePickerController *picker = [[HMImagePickerController alloc] initWithSelectedAssets:self.selectedAssets];
    
    // 设置图像选择代理
    picker.pickerDelegate = self;
    // 设置目标图片尺寸
    picker.targetSize = CGSizeMake(600, 600);
    // 设置最大选择照片数量
    picker.maxPickerCount = 9;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - HMImagePickerControllerDelegate
- (void)imagePickerController:(HMImagePickerController *)picker
      didFinishSelectedImages:(NSArray<UIImage *> *)images
               selectedAssets:(NSArray<PHAsset *> *)selectedAssets {

    // 记录图像，方便在 CollectionView 显示
    self.images = images;
    // 记录选中资源集合，方便再次选择照片定位
    self.selectedAssets = selectedAssets;
    
    [self.collectionView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MainViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.iconView.image = self.images[indexPath.item];
    
    return cell;
}

@end
