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
    [_scrollView addSubview:_imageView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _imageView.frame = _scrollView.bounds;
}

@end
