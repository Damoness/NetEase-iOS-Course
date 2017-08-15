//
//  OutputDeviceViewController.m
//  AudioPlayDemo2
//
//  Created by Chengyin on 16/8/7.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "OutputDeviceViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface OutputDeviceViewController ()
{
    UILabel *_label;
}
@end

@implementation OutputDeviceViewController

- (void)dealloc
{
    [self disableAudioSession];
}

- (void)loadView
{
    [super loadView];
    
    _label = [[UILabel alloc] init];
    _label.frame = self.view.bounds;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.numberOfLines = 0;
    [self.view addSubview:_label];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Output Device";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self displayCurrentOutputDevice];
    [self enableAudioSession];
}

- (void)enableAudioSession
{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(routeChanged:) name:AVAudioSessionRouteChangeNotification object:nil];
}

- (void)disableAudioSession
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionRouteChangeNotification object:nil];
    [[AVAudioSession sharedInstance] setActive:NO error:nil];
}

- (void)routeChanged:(NSNotification *)notification
{
    [self displayCurrentOutputDevice];
}

- (void)displayCurrentOutputDevice
{
    NSString *outputDeviceType = [[[AVAudioSession sharedInstance].currentRoute.outputs firstObject] portType];
    NSString *outputDeviceName = [[[AVAudioSession sharedInstance].currentRoute.outputs firstObject] portName];
    dispatch_async(dispatch_get_main_queue(), ^{
        _label.text = [NSString stringWithFormat:@"name = %@ \n type = %@",outputDeviceName,outputDeviceType];
    });
}
@end
