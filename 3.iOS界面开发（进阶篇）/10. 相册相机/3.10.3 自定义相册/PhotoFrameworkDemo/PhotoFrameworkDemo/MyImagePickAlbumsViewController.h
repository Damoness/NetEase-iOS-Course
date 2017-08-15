//
//  MyImagePickAlbumsViewController.h
//  PhotoFrameworkDemo
//
//  Created by Chengyin on 16/9/11.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHAssetCollection;
@class MyImagePickAlbumsViewController;
@protocol MyImagePickAlbumsViewControllerDelegate <NSObject>
@optional
- (void)imagePickAlbumsViewController:(MyImagePickAlbumsViewController *)imagePickAlbumsViewController didSelectAlbum:(PHAssetCollection *)album;
@end

@class PHAssetCollection;
@interface MyImagePickAlbumsViewController : UITableViewController

@property (nonatomic,weak) id<MyImagePickAlbumsViewControllerDelegate> delegate;

- (instancetype)initWithAssetCollections:(NSArray<PHAssetCollection *> *)assetCollections;
@end
