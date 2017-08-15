//
//  MyImagePickerViewController.h
//  PhotoFrameworkDemo
//
//  Created by Chengyin on 16/9/11.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHAsset;
@class MyImagePickerViewController;
@protocol MyImagePickerViewControllerDelegate <NSObject>
@optional
- (void)imagePickerViewController:(MyImagePickerViewController *)imagePickerViewController didSelectAssets:(NSArray<PHAsset *> *)assets;
@end

@interface MyImagePickerViewController : UICollectionViewController

@property (nonatomic,weak) id<MyImagePickerViewControllerDelegate> delegate;

@end
