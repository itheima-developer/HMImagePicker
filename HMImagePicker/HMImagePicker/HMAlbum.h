//
//  HMAlbum.h
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Photos;

/// 相册模型
@interface HMAlbum : NSObject

/// 构造函数
///
/// @param assetCollection 资源集合(某一个相册)
///
/// @return 相册模型
+ (_Nonnull instancetype)albumWithAssetCollection:(PHAssetCollection * _Nonnull)assetCollection;

/// 相册标题
@property (nonatomic, readonly, nullable) NSString *title;
/// 照片数量
@property (nonatomic, readonly) NSInteger count;
/// 相册描述信息
@property (nonatomic, readonly, nullable) NSAttributedString *desc;

/// 返回空白图片
///
/// @param size 图像尺寸
///
/// @return 空白图片
- (UIImage * _Nonnull)emptyImageWithSize:(CGSize)size;

/// 请求缩略图
///
/// @param size       缩略图尺寸
/// @param completion 完成回调
- (void)requestThumbnailWithSize:(CGSize)size completion:( void (^ _Nonnull)(UIImage * _Nonnull thumbnail))completion;

@end
