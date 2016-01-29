//
//  HMImagePickerController.h
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HMImagePickerControllerDelegate;

/// 图像选择控制器
@interface HMImagePickerController : UINavigationController
/// 图像选择代理
@property (nonatomic, weak) id<HMImagePickerControllerDelegate> pickerDelegate;
@end

/// 图像选择控制器协议
@protocol HMImagePickerControllerDelegate <NSObject>
@optional
/// 图像选择完成代理方法
///
/// @param picker   图像选择控制器
/// @param images   用户选中图像数组
- (void)imagePickerController:(HMImagePickerController *)picker didFinishSelectedImages:(NSArray <UIImage *> *)images;
@end