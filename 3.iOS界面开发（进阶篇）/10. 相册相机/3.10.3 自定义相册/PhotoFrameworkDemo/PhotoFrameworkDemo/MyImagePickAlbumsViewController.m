//
//  MyImagePickAlbumsViewController.m
//  PhotoFrameworkDemo
//
//  Created by Chengyin on 16/9/11.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "MyImagePickAlbumsViewController.h"
#import "PHAssetCollection+Poster.h"
#import <Photos/Photos.h>

@interface MyImageAlbumCell : UITableViewCell

@end

@implementation MyImageAlbumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.imageView.clipsToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    self.imageView.frame = CGRectMake(margin, 0 ,self.contentView.bounds.size.height,self.contentView.bounds.size.height);
    self.separatorInset = UIEdgeInsetsMake(0, margin * 2 + self.contentView.bounds.size.height, 0, 0);
    self.textLabel.frame = CGRectMake(margin * 2 + self.contentView.bounds.size.height, 0, self.textLabel.frame.size.width, self.contentView.bounds.size.height);
}
@end

@implementation MyImagePickAlbumsViewController
{
    NSArray<PHAssetCollection *> *_albums;
}

- (instancetype)initWithAssetCollections:(NSArray<PHAssetCollection *> *)assetCollections
{
    self = [self initWithStyle:UITableViewStylePlain];
    if (self)
    {
        _albums = [assetCollections copy];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    }
    return self;
}

- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _albums.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"albumCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[MyImageAlbumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [_albums[indexPath.row] localizedTitle];
    cell.imageView.image = [_albums[indexPath.row] pi_poster];
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([_delegate respondsToSelector:@selector(imagePickAlbumsViewController:didSelectAlbum:)]) {
        [_delegate imagePickAlbumsViewController:self didSelectAlbum:_albums[indexPath.row]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
