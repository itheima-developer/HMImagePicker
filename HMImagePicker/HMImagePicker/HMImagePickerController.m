//
//  HMImagePickerController.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMImagePickerController.h"
#import "HMAlbumTableViewController.h"

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
        
        [self pushViewController:_rootViewController animated:NO];
    }
    return self;
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

@end
