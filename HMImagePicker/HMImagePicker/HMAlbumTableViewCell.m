//
//  HMAlbumTableViewCell.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMAlbumTableViewCell.h"

@implementation HMAlbumTableViewCell

#pragma mark - 构造函数
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.numberOfLines = 0;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.contentView.bounds;
    CGFloat iconMargin = 8.0;
    CGFloat iconWH = rect.size.height - 2 * iconMargin;
    
    self.imageView.frame = CGRectMake(iconMargin, iconMargin, iconWH, iconWH);
    
    CGFloat labelMargin = 12.0;
    CGFloat labelX = iconMargin + iconWH + labelMargin;
    CGFloat labelW = rect.size.width - labelX - labelMargin;
    self.textLabel.frame = CGRectMake(labelX, iconMargin, labelW, iconWH);
}

#pragma mark - 设置数据
- (void)setAssetCollection:(PHAssetCollection *)assetCollection {
    _assetCollection = assetCollection;
    
    // 设置查询选项
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    // 仅搜索照片
    options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d", PHAssetMediaTypeImage];
    // 按照创建日期降序排列照片
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:
     [[NSAttributedString alloc] initWithString:assetCollection.localizedTitle]
     ];
    [attributedString appendAttributedString:
     [[NSAttributedString alloc]
      initWithString:[NSString stringWithFormat:@"\n%zd", fetchResult.count]
      attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}]
     ];
    
    self.textLabel.attributedText = attributedString;
    
    {
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        // 设置 resizeMode 可以按照指定大小缩放图像
        options.resizeMode = PHImageRequestOptionsResizeModeFast;
        
        [[PHImageManager defaultManager]
         requestImageForAsset:fetchResult.lastObject
         targetSize:CGSizeMake(600, 600)
         contentMode:PHImageContentModeAspectFill
         options:options
         resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            self.imageView.image = result;
            NSLog(@"%@", result);
        }];
    }
}

@end
