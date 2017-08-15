//
//  VideoPlayerViewController.h
//  VideoDemo
//
//  Created by Chengyin on 16/9/17.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import <AVKit/AVKit.h>

@interface VideoPlayerViewController : AVPlayerViewController

- (instancetype)initWithURL:(NSURL *)url;
@end
