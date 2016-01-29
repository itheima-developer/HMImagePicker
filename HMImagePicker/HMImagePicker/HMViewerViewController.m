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
    UILabel *_label;
}

- (void)setIndex:(NSUInteger)index {
    _index = index;
    
    [self view];
    
    _label.text = [NSString stringWithFormat:@"%zd", index];
}

- (void)loadView {
    _scrollView = [[UIScrollView alloc] init];
    self.view = _scrollView;
    
    _imageView = [[UIImageView alloc] init];
    [_scrollView addSubview:_imageView];
    
    _label = [[UILabel alloc] init];
    _label.textColor = [UIColor blackColor];
    _label.font = [UIFont systemFontOfSize:40];
    _label.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_label];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _imageView.frame = _scrollView.bounds;
    _label.frame = _scrollView.bounds;
}

@end
