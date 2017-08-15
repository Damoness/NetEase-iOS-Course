//
//  MyImagePreviewViewController.h
//  PhotoFrameworkDemo
//
//  Created by Chengyin on 16/9/11.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyImagePreviewViewController;
@protocol MyImagePreviewViewControllerDelegate <NSObject>
@optional
- (void)imagePreviewViewControllerDidSelectImage:(MyImagePreviewViewController *)imagePreviewViewController;
@end

@class PHAsset;
@interface MyImagePreviewViewController : UIViewController

@property (nonatomic,weak) id<MyImagePreviewViewControllerDelegate> delegate;
@property (nonatomic,strong,readonly) PHAsset *asset;

- (instancetype)initWithAsset:(PHAsset *)asset;
@end
