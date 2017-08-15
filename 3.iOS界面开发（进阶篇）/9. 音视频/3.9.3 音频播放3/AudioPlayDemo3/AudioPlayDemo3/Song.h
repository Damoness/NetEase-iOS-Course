//
//  Song.h
//  AudioPlayDemo1
//
//  Created by Chengyin on 16/7/31.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MPMediaItem;
@class AVURLAsset;
@interface Song : NSObject

@property (nonatomic,copy,readonly) NSString *name;
@property (nonatomic,copy,readonly) NSString *album;
@property (nonatomic,copy,readonly) NSString *artist;
@property (nonatomic,strong,readonly) UIImage *cover;

@property (nonatomic,copy,readonly) AVURLAsset *asset;

- (instancetype)initWithMediaItem:(MPMediaItem *)mediaItem;
- (instancetype)initWithFilePath:(NSString *)filePath;
- (instancetype)initWithURL:(NSURL *)url name:(NSString *)name artist:(NSString *)artist album:(NSString *)album;
@end
