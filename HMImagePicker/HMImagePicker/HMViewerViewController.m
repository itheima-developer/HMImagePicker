//
//  HMViewerViewController.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/29.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMViewerViewController.h"

@interface HMViewerViewController ()

@end

@implementation HMViewerViewController {
    UIScrollView *_scrollView;
    UIImageView *_imageView;
}

- (void)setAsset:(PHAsset *)asset {
    _asset = asset;
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    [[PHImageManager defaultManager]
     requestImageForAsset:_asset
     targetSize:[UIScreen mainScreen].bounds.size
     contentMode:PHImageContentModeAspectFill
     options:options
     resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
         UIImage *image = [UIImage imageWithCGImage:result.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
         _imageView.image = image;
         
         [self setImageViewPosition];
     }];
}

- (void)setImageViewPosition {
    
    CGSize size = [self displaySize:_imageView.image];
    _scrollView.contentSize = size;
    
    if (size.height > _scrollView.bounds.size.height) {
        _imageView.frame = CGRectMake(0, 0, size.width, size.height);
    } else {
        CGFloat y = (_scrollView.bounds.size.height - size.height) * 0.5;
        _imageView.frame = CGRectMake(0, y, size.width, size.height);
    }
}

/// 根据视图大小，等比例计算图像缩放大小
///
/// @param image 图像
///
/// @return 缩放后的大小
- (CGSize)displaySize:(UIImage *)image {
    CGFloat w = self.view.bounds.size.width;
    CGFloat h = image.size.height * w / image.size.width;
    
    return CGSizeMake(w, h);
}

#pragma mark - 视图生命周期
- (void)loadView {
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.view = _scrollView;
    
    _imageView = [[UIImageView alloc] init];
    [_scrollView addSubview:_imageView];
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setImageViewPosition];
    });
}

@end
