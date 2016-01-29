//
//  HMImageGridViewController.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMImageGridViewController.h"
#import "HMAlbum.h"

@interface HMImageGridViewController ()

@end

@implementation HMImageGridViewController {
    /// 相册模型
    HMAlbum *_album;
}

#pragma mark - 构造函数

- (instancetype)initWithAlbum:(HMAlbum *)album {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        _album = album;
        
        self.collectionView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)clickCloseButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
