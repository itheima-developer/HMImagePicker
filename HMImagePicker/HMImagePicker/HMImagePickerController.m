//
//  HMImagePickerController.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMImagePickerController.h"
#import "HMAlbumTools.h"
#import "HMImageGridViewController.h"

@interface HMImagePickerController ()

@end

@implementation HMImagePickerController {
    HMImageGridViewController *_rootViewController;
}

#pragma mark - 构造函数
- (instancetype)init {
    self = [super init];
    if (self) {
        
        [HMAlbumTools fetchAssetCollectionWithCompletion:^(NSArray<PHAssetCollection *> *assetCollection, BOOL isDenied) {
            NSLog(@"%@ %d", assetCollection, isDenied);
        }];
        
        _rootViewController = [[HMImageGridViewController alloc] init];
        
        [self pushViewController:_rootViewController animated:NO];
    }
    return self;
}

@end
