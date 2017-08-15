//
//  MyImagePickerCell.h
//  PhotoFrameworkDemo
//
//  Created by Chengyin on 16/9/11.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyImagePickerCell;
@protocol MyImagePickerCellDelegate <NSObject>
@optional
- (void)imagePickerCellCheckBoxClicked:(MyImagePickerCell *)cell;
@end

@interface MyImagePickerCell : UICollectionViewCell

@property (nonatomic,weak) id<MyImagePickerCellDelegate> delegate;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,assign) BOOL userSelected;

@end
