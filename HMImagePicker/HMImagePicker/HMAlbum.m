//
//  HMAlbum.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMAlbum.h"

@implementation HMAlbum {
    /// 当前相册资源集合
    PHAssetCollection *_assetCollection;
    /// 当前相册内的资源查询结果
    PHFetchResult *_fetchResult;
}
@synthesize desc = _desc;

#pragma mark - 构造函数
+ (instancetype)albumWithAssetCollection:(PHAssetCollection *)assetCollection {
    return [[self alloc] initWithAssetCollection:assetCollection];
}

- (instancetype)initWithAssetCollection:(PHAssetCollection *)assetCollection {
    self = [super init];
    if (self) {
        // 设置查询选项
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        // 仅搜索照片
        options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d", PHAssetMediaTypeImage];
        // 按照创建日期降序排列照片
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        
        _assetCollection = assetCollection;
        _fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
    }
    return self;
}

#pragma mark - 只读属性
- (NSString *)title {
    return _assetCollection.localizedTitle;
}

- (NSInteger)count {
    return _fetchResult.count;
}

- (NSAttributedString *)desc {
    if (_desc == nil) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
        
        [attributedString appendAttributedString:
         [[NSAttributedString alloc] initWithString:_assetCollection.localizedTitle]
         ];
        [attributedString appendAttributedString:
         [[NSAttributedString alloc]
          initWithString:[NSString stringWithFormat:@"\n%zd", _fetchResult.count]
          attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}]
         ];
        
        _desc = attributedString.copy;

    }
    return _desc;
}

@end
