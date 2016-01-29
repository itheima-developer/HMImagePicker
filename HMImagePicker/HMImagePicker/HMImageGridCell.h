//
//  HMImageGridCell.h
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/29.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HMImageGridCellDelegate;

/// 多图选择视图 Cell
@interface HMImageGridCell : UICollectionViewCell
@property (nonatomic, weak) id<HMImageGridCellDelegate> delegate;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIButton *selectedButton;
@end

@protocol HMImageGridCellDelegate <NSObject>
/// 图像 Cell 选中事件
///
/// @param cell     图像 cell
/// @param selected 是否选中
- (void)imageGridCell:(HMImageGridCell *)cell didSelected:(BOOL)selected;
@end