//
//  HMAlbumTableViewController.h
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Photos;

/// 相册列表控制器
@interface HMAlbumTableViewController : UITableViewController
/// 选中素材数组
@property (nonatomic) NSMutableArray <PHAsset *> *selectedAssets;
@end
