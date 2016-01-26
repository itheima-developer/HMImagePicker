//
//  HMImagePickerController.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMImagePickerController.h"
#import "HMImageGridViewController.h"

@interface HMImagePickerController ()

@end

@implementation HMImagePickerController

- (instancetype)init {
    self = [super init];
    if (self) {
        HMImageGridViewController *vc = [[HMImageGridViewController alloc] init];
        
        [self pushViewController:vc animated:NO];
    }
    return self;
}

@end
