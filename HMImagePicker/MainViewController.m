//
//  MainViewController.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "MainViewController.h"
#import "HMImagePickerController.h"

@interface MainViewController () <HMImagePickerControllerDelegate>

@end

@implementation MainViewController

- (IBAction)clickSelectPhotoButton {
    HMImagePickerController *picker = [[HMImagePickerController alloc] init];
    
    picker.pickerDelegate = self;
    picker.targetSize = CGSizeMake(300, 300);
    picker.maxPickerCount = 3;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - HMImagePickerControllerDelegate
- (void)imagePickerController:(HMImagePickerController *)picker didFinishSelectedImages:(NSArray<UIImage *> *)images {
    NSLog(@"%@", images);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
