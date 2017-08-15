//
//  VideoPlayerLayerViewController.m
//  VideoDemo
//
//  Created by Chengyin on 16/9/17.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "VideoPlayerLayerViewController.h"
#import <AVFoundation/AVFoundation.h>

static NSString* const AVPlayerReadyObservationContext = @"AVPlayerReadyObservationContext";

@interface VideoPlayerLayerViewController ()
{
@private
    AVPlayerLayer *_playerLayer;
}
@end

@implementation VideoPlayerLayerViewController
- (instancetype)initWithURL:(NSURL *)url
{
    self = [self init];
    if (self)
    {
        AVPlayer *player = [AVPlayer playerWithURL:url];
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        
        [_playerLayer addObserver:self forKeyPath:@"readyForDisplay" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(AVPlayerReadyObservationContext)];
    }
    return self;
}

- (void)dealloc
{
    [_playerLayer removeObserver:self forKeyPath:@"readyForDisplay"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (context == (__bridge void * _Nullable)(AVPlayerReadyObservationContext))
    {
        [_playerLayer.player play];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    [self.view.layer addSublayer:_playerLayer];
    
    //add play ui
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _playerLayer.frame = self.view.layer.bounds;
    
    //layout
}
@end