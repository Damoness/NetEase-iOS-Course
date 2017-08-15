//
//  VideoPlayerViewController.m
//  VideoDemo
//
//  Created by Chengyin on 16/9/17.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

static NSString* const AVPlayerReadyObservationContext = @"AVPlayerReadyObservationContext";

@implementation VideoPlayerViewController
- (instancetype)initWithURL:(NSURL *)url
{
    self = [self init];
    if (self)
    {
        AVPlayer *player = [AVPlayer playerWithURL:url];
        self.player = player;
        
        [self addObserver:self forKeyPath:@"readyForDisplay" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(AVPlayerReadyObservationContext)];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"readyForDisplay"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.contentOverlayView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (context == (__bridge void * _Nullable)(AVPlayerReadyObservationContext))
    {
        [self.player play];
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
@end
