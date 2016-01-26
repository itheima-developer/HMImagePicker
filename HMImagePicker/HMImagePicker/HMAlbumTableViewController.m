//
//  HMAlbumTableViewController.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMAlbumTableViewController.h"
#import "HMAlbumTools.h"
#import "HMAlbumTableViewCell.h"

static NSString *const HMAlbumTableViewCellIdentifier = @"HMAlbumTableViewCellIdentifier";

@interface HMAlbumTableViewController ()

@end

@implementation HMAlbumTableViewController {
    /// 相册资源集合
    NSArray<HMAlbum *> *_assetCollection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"照片";
    
    [HMAlbumTools fetchAssetCollectionWithCompletion:^(NSArray<HMAlbum *> *assetCollection, BOOL isDenied) {
        _assetCollection = assetCollection;
        
        [self.tableView reloadData];
    }];
    
    [self.tableView registerClass:[HMAlbumTableViewCell class] forCellReuseIdentifier:HMAlbumTableViewCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 80;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _assetCollection.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HMAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HMAlbumTableViewCellIdentifier forIndexPath:indexPath];
    
    cell.album = _assetCollection[indexPath.row];
    
    return cell;
}

@end
