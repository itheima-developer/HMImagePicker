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

- (void)loadView {
    _scrollView = [[UIScrollView alloc] init];
    
    self.view = _scrollView;
    
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_imageView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    [[PHImageManager defaultManager]
     requestImageForAsset:_asset
     targetSize:[UIScreen mainScreen].nativeBounds.size
     contentMode:PHImageContentModeAspectFit
     options:options
     resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
         _imageView.image = result;
     }];
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _imageView.frame = _scrollView.bounds;
}

@end
