//
//  HMImageGridViewController.h
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Photos;
@class HMAlbum;

/// 多图选择控制器
@interface HMImageGridViewController : UICollectionViewController
/// 构造函数
///
/// @return 相册模型
- (instancetype)initWithAlbum:(HMAlbum *)album selectedAssets:(NSMutableArray <PHAsset *> *)selectedAssets;
@end
