//
//  MainViewController.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "MainViewController.h"
#import "HMImagePickerController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (IBAction)clickSelectPhotoButton {
    HMImagePickerController *picker = [[HMImagePickerController alloc] init];
    
    [self presentViewController:picker animated:YES completion:nil];
}

@end
