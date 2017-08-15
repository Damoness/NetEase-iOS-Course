//
//  PHAsset+FetchImage.h
//  PhotoFrameworkDemo
//
//  Created by Chengyin on 16/9/25.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHAsset (FetchImage)
- (UIImage *)fi_fastFullScreenImage;
- (UIImage *)fi_aspectThumbnailImageWithSize:(CGSize)size;
- (UIImage *)fi_aspectFillImageWithSize:(CGSize)size;
- (UIImage *)fi_originalImage;
- (UIImage *)fi_exactSquareImageWithSize:(CGSize)size;
@end
