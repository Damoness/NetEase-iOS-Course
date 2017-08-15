//
//  PHAsset+FetchImage.m
//  PhotoFrameworkDemo
//
//  Created by Chengyin on 16/9/25.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "PHAsset+FetchImage.h"

@implementation PHAsset (FetchImage)
- (UIImage *)fi_fastFullScreenImage
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    
    __block UIImage *image = nil;
    [[PHImageManager defaultManager] requestImageForAsset:self
                                               targetSize:CGSizeMake(screenSize.width * scale, screenSize.height * scale)
                                              contentMode:PHImageContentModeAspectFit
                                                  options:options
                                            resultHandler:^(UIImage *result, NSDictionary *info) {
                                                image = result;
                                            }];
    return image;
}

- (UIImage *)fi_aspectThumbnailImageWithSize:(CGSize)size
{
    CGSize targetSize = size;
    CGFloat side = MIN(targetSize.width, targetSize.height);
    CGFloat ratio = 360 / side;//thumbnail大小取360为上限是出于同步取图的性能考虑
    if (ratio < 1)
    {
        targetSize.width = targetSize.width * ratio;
        targetSize.height = targetSize.height * ratio;
    }
    return [self fi_aspectFillImageWithSize:targetSize];
}

- (UIImage *)fi_aspectFillImageWithSize:(CGSize)size
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    CGSize targetSize = size;
    CGSize imageSize = CGSizeMake(self.pixelWidth, self.pixelHeight);
    if (targetSize.width >= imageSize.width && targetSize.height >= imageSize.height)
    {
        targetSize = imageSize;
    }
    
    __block UIImage *image = nil;
    [[PHImageManager defaultManager] requestImageForAsset:self
                                               targetSize:targetSize
                                              contentMode:PHImageContentModeAspectFill
                                                  options:options
                                            resultHandler:^(UIImage *result, NSDictionary *info) {
                                                image = result;
                                            }];
    return image;
}

- (UIImage *)fi_originalImage
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.version = PHImageRequestOptionsVersionCurrent;
    options.synchronous = YES;
    
    __block UIImage *image = nil;
    [[PHImageManager defaultManager] requestImageForAsset:self
                                               targetSize:PHImageManagerMaximumSize
                                              contentMode:PHImageContentModeDefault
                                                  options:options
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                image = result;
                                            }];
    return image;
}

- (UIImage *)fi_exactSquareImageWithSize:(CGSize)size
{
    CGSize targetSize = size;
    if (targetSize.width - targetSize.height > DBL_EPSILON)
    {
        CGFloat targetSide = MIN(targetSize.width, targetSize.height);
        targetSize = CGSizeMake(targetSide, targetSide);
    }
    
    CGSize imageSize = CGSizeMake(self.pixelWidth, self.pixelHeight);
    CGFloat side = MIN(imageSize.width, imageSize.height);
    if (targetSize.width > side)
    {
        targetSize = CGSizeMake(side, side);
    }
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.normalizedCropRect = CGRectApplyAffineTransform(CGRectMake(0, 0, side, side),CGAffineTransformMakeScale(1.0 / imageSize.width,1.0 / imageSize.height));
    
    __block UIImage *image = nil;
    [[PHImageManager defaultManager] requestImageForAsset:self
                                               targetSize:targetSize
                                              contentMode:PHImageContentModeAspectFit
                                                  options:options
                                            resultHandler:^(UIImage *result, NSDictionary *info) {
                                                image = result;
                                            }];
    return image;
}
@end