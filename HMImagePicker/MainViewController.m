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
    
    picker.pickerDelegate = self;
    picker.targetSize = CGSizeMake(300, 300);
    picker.maxPickerCount = 9;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - HMImagePickerControllerDelegate
- (void)imagePickerController:(HMImagePickerController *)picker
      didFinishSelectedImages:(NSArray<UIImage *> *)images
               selectedAssets:(NSArray<PHAsset *> *)selectedAssets {

    self.images = images;
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
