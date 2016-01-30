//
//  HMPreviewViewController.h
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/29.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMAlbum.h"

/// 照片预览控制器代理
@protocol HMPreviewViewControllerDelegate;

/// 照片预览控制器
@interface HMPreviewViewController : UIViewController
/// 构造函数
///
/// @param album          相册模型
/// @param selectedAssets 选中资源数组
/// @param maxPickerCount 最大选择数量
/// @param previewAlbum   预览相册
///
/// @return 多图选择控制器
- (instancetype)initWithAlbum:(HMAlbum *)album
               selectedAssets:(NSMutableArray <PHAsset *> *)selectedAssets
               maxPickerCount:(NSInteger)maxPickerCount
                 previewAlbum:(BOOL)previewAlbum;

@property (nonatomic, weak) id<HMPreviewViewControllerDelegate> delegate;
@end


@protocol HMPreviewViewControllerDelegate <NSObject>

/// 预览控制器修改资源选中状态
///
/// @param previewViewController 预览控制器
/// @param asset                 资源
/// @param selected              是否选中
///
/// @return 是否允许修改
- (BOOL)previewViewController:(HMPreviewViewController *)previewViewController didChangedAsset:(PHAsset *)asset selected:(BOOL)selected;

@end