//
//  HMImagePickerController.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMImagePickerController.h"
#import "HMAlbumTableViewController.h"

NSString *const HMImagePickerDidSelectedNotification = @"HMImagePickerDidSelectedNotification";
NSString *const HMImagePickerDidSelectedAssetsKey = @"HMImagePickerDidSelectedAssetsKey";

@interface HMImagePickerController ()

@end

@implementation HMImagePickerController {
    HMAlbumTableViewController *_rootViewController;
}

#pragma mark - 构造函数
- (instancetype)init {
    self = [super init];
    if (self) {
        _rootViewController = [[HMAlbumTableViewController alloc] init];
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(didFinishedSelectAssets:)
         name:HMImagePickerDidSelectedNotification
         object:nil];
        
        [self pushViewController:_rootViewController animated:NO];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HMImagePickerDidSelectedNotification object:nil];
}

- (void)didFinishedSelectAssets:(NSNotification *)notification {
    
    NSArray <PHAsset *> *selectedAssets = notification.userInfo[HMImagePickerDidSelectedAssetsKey];
    
    if (![self.pickerDelegate respondsToSelector:@selector(imagePickerController:didFinishSelectedImages:)] || selectedAssets == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
        return;
    }
    
    [self requestImages:selectedAssets completed:^(NSArray<UIImage *> *images) {
        [self.pickerDelegate imagePickerController:self didFinishSelectedImages:images];
    }];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.toolbarHidden = [viewController isKindOfClass:[HMAlbumTableViewController class]];
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIViewController *viewController = [super popViewControllerAnimated:animated];
    
    self.toolbarHidden = (viewController != self.topViewController);
    
    return viewController;
}

#pragma mark - 请求图像方法
/// 根据 PHAsset 数组，统一查询用户选中图像
///
/// @param selectedAssets 用户选中 PHAsset 数组
/// @param completed      完成回调，缩放后的图像数组在回调参数中
- (void)requestImages:(NSArray <PHAsset *> *)selectedAssets completed:(void (^)(NSArray <UIImage *> *images))completed {
    
    /// 图像请求选项
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 设置 resizeMode 可以按照指定大小缩放图像
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    // 设置 deliveryMode 为 HighQualityFormat 可以只回调一次缩放之后的图像，否则会调用多次
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    // 设置加载图像尺寸(以像素为单位)
    // TODO: - 设置图像大小
    CGSize targetSize = CGSizeMake(600, 600);
    
    NSMutableArray <UIImage *> *images = [NSMutableArray array];
    dispatch_group_t group = dispatch_group_create();
    
    for (PHAsset *asset in selectedAssets) {
        
        dispatch_group_enter(group);
        
        [[PHImageManager defaultManager]
         requestImageForAsset:asset
         targetSize:targetSize
         contentMode:PHImageContentModeAspectFill
         options:options
         resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
             
             [images addObject:result];
             dispatch_group_leave(group);
         }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        completed(images.copy);
    });
}

@end
