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

+ (_Nonnull instancetype)albumWithAssetCollection:(PHAssetCollection * _Nonnull)assetCollection;
- (_Nonnull instancetype)initWithAssetCollection:(PHAssetCollection * _Nonnull)assetCollection;

/// 当前相册内的资源查询结果
@property (nonatomic, nullable) PHFetchResult *fetchResult;
/// 相册标题
@property (nonatomic, readonly, nullable) NSString *title;
/// 照片数量
@property (nonatomic, readonly) NSInteger count;
/// 相册描述信息
@property (nonatomic, readonly, nullable) NSAttributedString *desc;
@end
