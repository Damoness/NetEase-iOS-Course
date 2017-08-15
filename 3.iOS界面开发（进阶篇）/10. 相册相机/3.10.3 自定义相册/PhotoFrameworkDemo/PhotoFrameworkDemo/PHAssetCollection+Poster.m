//
//  PHAssetCollection+Poster.m
//  PhotoFrameworkDemo
//
//  Created by Chengyin on 16/9/25.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "PHAssetCollection+Poster.h"
#import "PHAsset+FetchImage.h"

@implementation PHAssetCollection (Poster)
- (UIImage *)pi_poster
{
    return [self pi_posterWithSize:CGSizeMake(75, 75)];
}

- (UIImage *)pi_posterWithSize:(CGSize)size
{
    CGFloat scale = [UIScreen mainScreen].scale;
    PHAsset *keyAsset = [[PHAsset fetchKeyAssetsInAssetCollection:self options:nil] firstObject];
    UIImage *poster = [keyAsset fi_aspectThumbnailImageWithSize:CGSizeMake(size.width * scale, size.height * scale)];
    return poster;
}
@end
