//
//  MyImagePickerCell.m
//  PhotoFrameworkDemo
//
//  Created by Chengyin on 16/9/11.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "MyImagePickerCell.h"

@interface CheckBox : UIButton
@end

@implementation CheckBox
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect bounds = self.bounds;
    CGFloat widthDelta = MAX(60.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(60.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}
@end

@implementation MyImagePickerCell
{
    UIImageView *_imageView;
    CheckBox *_button;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
        
        _button = [CheckBox buttonWithType:UIButtonTypeCustom];
        [_button addTarget:self action:@selector(checkBoxClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_button setBackgroundImage:[UIImage imageNamed:@"checkboxBg"] forState:UIControlStateNormal];
        [_button setImage:[UIImage imageNamed:@"checkmark"] forState:UIControlStateSelected];
        [self.contentView addSubview:_button];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = self.contentView.bounds;
    
    CGFloat buttonSize = 25;
    CGFloat margin = 2;
    _button.frame = CGRectMake(self.contentView.bounds.size.width - buttonSize - margin, margin, buttonSize, buttonSize);
}

- (void)setUserSelected:(BOOL)userSelected
{
    _userSelected = userSelected;
    _button.selected = _userSelected;
}

- (void)checkBoxClicked:(id)sender
{
    if ([_delegate respondsToSelector:@selector(imagePickerCellCheckBoxClicked:)])
    {
        [_delegate imagePickerCellCheckBoxClicked:self];
    }
}

- (void)setImage:(UIImage *)image
{
    _imageView.image = image;
}

- (UIImage *)image
{
    return _imageView.image;
}
@end
