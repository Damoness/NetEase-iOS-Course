//
//  PlayerLayerViewController.m
//  VideoDemo
//
//  Created by Chengyin on 16/9/5.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "PlayerLayerViewController.h"
#import "VideoPlayerLayerViewController.h"

@interface PlayerLayerViewController ()
{
    VideoPlayerLayerViewController *_playerViewController;
}
@end

@implementation PlayerLayerViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"AVPlayerLayerViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"播放" style:UIBarButtonItemStylePlain target:self action:@selector(playClicked:)];
}

- (void)playClicked:(id)sender
{
    //如果无法播放，请更换URL
    NSURL *videoURL = [NSURL URLWithString:@"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"];
    _playerViewController = [[VideoPlayerLayerViewController alloc] initWithURL:videoURL];
    [self presentViewController:_playerViewController animated:YES completion:nil];
}
@end
