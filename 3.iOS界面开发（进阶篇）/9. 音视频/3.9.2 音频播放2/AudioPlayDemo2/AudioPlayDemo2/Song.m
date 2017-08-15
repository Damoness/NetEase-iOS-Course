//
//  Song.m
//  AudioPlayDemo1
//
//  Created by Chengyin on 16/7/31.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "Song.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface Song ()

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *album;
@property (nonatomic,copy) NSString *artist;
@property (nonatomic,strong) UIImage *cover;

@end

@implementation Song
- (NSString *)name
{
    if (_name.length == 0)
    {
        return @"未知歌曲";
    }
    return _name;
}

- (NSString *)artist
{
    if (_artist.length == 0)
    {
        return @"未知歌手";
    }
    return _artist;
}

- (NSString *)album
{
    if (_album.length == 0)
    {
        return @"未知专辑";
    }
    return _album;
}

- (instancetype)initWithAsset:(AVURLAsset *)asset fetchMetadata:(BOOL)fetchMetadata
{
    if (!asset)
    {
        return nil;
    }
    
    self = [self init];
    if (self)
    {
        _asset = [asset copy];
        
        if (fetchMetadata)
        {
            NSArray<AVMetadataItem *> *metadatas = asset.commonMetadata;
            for (AVMetadataItem *metadata in metadatas)
            {
                if ([metadata.commonKey isEqualToString:AVMetadataCommonKeyTitle])
                {
                    _name = metadata.stringValue;
                }
                else if ([metadata.commonKey isEqualToString:AVMetadataCommonKeyArtist])
                {
                    _artist = metadata.stringValue;
                }
                else if ([metadata.commonKey isEqualToString:AVMetadataCommonKeyAlbumName])
                {
                    _album = metadata.stringValue;
                }
                else if ([metadata.commonKey isEqualToString:AVMetadataCommonKeyArtwork] && [metadata.value isKindOfClass:[NSData class]])
                {
                    NSData *data = (NSData *)metadata.value;
                    _cover = [UIImage imageWithData:data];
                }
            }
        }
    }
    return self;
}

- (instancetype)initWithMediaItem:(MPMediaItem *)mediaItem
{
    AVURLAsset *asset = [AVURLAsset assetWithURL:mediaItem.assetURL];
    return [self initWithAsset:asset fetchMetadata:YES];
}

- (instancetype)initWithFilePath:(NSString *)filePath
{
    AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:filePath]];
    return [self initWithAsset:asset fetchMetadata:YES];
}

- (instancetype)initWithURL:(NSURL *)url name:(NSString *)name artist:(NSString *)artist album:(NSString *)album
{
    AVURLAsset *asset = [AVURLAsset assetWithURL:url];
    self = [self initWithAsset:asset fetchMetadata:NO];//在线音频不获取metadata
    if (self)
    {
        self.name = name;
        self.artist = artist;
        self.album = album;
    }
    return self;
}
@end