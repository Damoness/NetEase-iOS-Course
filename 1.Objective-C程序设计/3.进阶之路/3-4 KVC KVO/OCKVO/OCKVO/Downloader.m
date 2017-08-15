//  ...
//  Downloader.m
//  OCBlock2
//
//  Created by oldman on 8/22/16.
//  Copyright © 2016 Netease. All rights reserved.
//

#import "Downloader.h"

@implementation Downloader

- (void)download {
    for (CGFloat progress = 0; progress <= 1.0; progress += 0.25) {
        self.progress = progress;
    }
}

@end
