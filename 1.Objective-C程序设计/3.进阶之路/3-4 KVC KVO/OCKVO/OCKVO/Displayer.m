//
//  Displayer.m
//  OCARC3
//
//  Created by oldman on 9/10/16.
//
//

#import "Displayer.h"
#import "Downloader.h"

@interface Displayer ()
@property CGFloat downloadProgress;
@property Downloader* downloader;
@end

@implementation Displayer

- (instancetype)init {
    if (self = [super init]) {
        _downloader = [[Downloader alloc] init];
    }
    return self;
}

- (void)download {
    [self.downloader addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew context:nil];
    [self.downloader download];
    [self.downloader removeObserver:self forKeyPath:@"progress"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"progress"]) {
        NSNumber* freshProgress = change[NSKeyValueChangeNewKey];
        self.downloadProgress = [freshProgress floatValue];
        [self doDisplay];
    }
}


- (void)doDisplay {
    NSLog(@"已下载: %@", @(self.downloadProgress));
}

- (void)dealloc {
    //[self.downloader removeObserver:self forKeyPath:@"progress"];
}

@end
