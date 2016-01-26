//
//  HMAlbumTools.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMAlbumTools.h"
#import "HMAlbum.h"

@implementation HMAlbumTools

+ (void)fetchAssetCollectionWithCompletion:(void (^)(NSArray<HMAlbum *> *, BOOL))completion {
    NSAssert(completion != nil, @"必须传入完成回调");
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    switch (status) {
        case PHAuthorizationStatusAuthorized:
            [self fetchResultWithCompletion:completion];
            break;
        case PHAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                [self fetchResultWithCompletion:completion];
            }];
        }
            break;
        default:
            NSLog(@"拒绝访问相册");
            completion(nil, YES);
            
            break;
    }
}

+ (void)fetchResultWithCompletion:(void (^)(NSArray<HMAlbum *> *, BOOL))completion {
    // 相机胶卷
    PHFetchResult *userLibrary = [PHAssetCollection
                                  fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                  subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary
                                  options:nil];
    
    // 同步相册
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"localizedTitle" ascending:NO]];
    
    PHFetchResult *syncedAlbum = [PHAssetCollection
                                  fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                  subtype:PHAssetCollectionSubtypeAlbumSyncedAlbum
                                  options:options];
    
    NSMutableArray *result = [NSMutableArray array];
    [userLibrary enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [result addObject:[HMAlbum albumWithAssetCollection:obj]];
    }];
    [syncedAlbum enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [result addObject:[HMAlbum albumWithAssetCollection:obj]];
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{ completion(result.copy, NO); });
}

@end
