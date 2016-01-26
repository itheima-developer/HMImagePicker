//
//  HMAlbumTools.h
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Photos;

/// 相册工具
@interface HMAlbumTools : NSObject

/// 加载相册资源列表
///
/// @param completion 完成回调
+ (void)fetchAssetCollectionWithCompletion:(void (^)(NSArray <PHAssetCollection *> *assetCollection, BOOL isDenied))completion;

@end
