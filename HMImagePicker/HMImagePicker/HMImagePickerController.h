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
/// 加载图像尺寸(以像素为单位，默认大小 600 * 600)
@property (nonatomic) CGSize targetSize;
/// 最大选择图像数量，默认 9 张
@property (nonatomic) NSInteger maxPickerCount;
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