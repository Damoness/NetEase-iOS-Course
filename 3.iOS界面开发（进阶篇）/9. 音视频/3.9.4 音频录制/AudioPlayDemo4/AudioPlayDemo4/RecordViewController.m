//
//  RecordViewController.m
//  AudioPlayDemo4
//
//  Created by Chengyin on 16/8/21.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "RecordViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CPRecordWaveView.h"

@interface RecordViewController ()<AVAudioRecorderDelegate>
{
    AVAudioRecorder *_recorder;
    AVAsset *_asset;
    AVAudioPlayer *_player;
    CPRecordWaveView *_waveView;
    
    NSTimer *_recordTimer;
}
@end

@implementation RecordViewController

- (void)dealloc
{
    [self enableAudioSession:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Play" style:UIBarButtonItemStylePlain target:self action:@selector(playButtonClicked:)];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Record Audio";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interrupted:) name:AVAudioSessionInterruptionNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(routeChanged:) name:AVAudioSessionRouteChangeNotification object:nil];
    [self requestRecordPermission:^(BOOL granted) {
        if (granted)
        {
            [self enableAudioSession:YES];
        }
        else
        {
            //提示失败
            //这里如果要显示UI的话记得到主线程显示
        }
    }];
    
    _waveView = [[CPRecordWaveView alloc] init];
    _waveView.bounds = CGRectMake(0, 0, 200, 200);
    _waveView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    _waveView.color = [UIColor redColor];
    [self.view addSubview:_waveView];
}

- (void)requestRecordPermission:(PermissionBlock)block
{
    AVAudioSessionRecordPermission permission = [[AVAudioSession sharedInstance] recordPermission];
    if (permission == AVAudioSessionRecordPermissionUndetermined)
    {
        [[AVAudioSession sharedInstance] requestRecordPermission:block];
    }
    else if (permission == AVAudioSessionRecordPermissionGranted)
    {
        if (block)
        {
            block(YES);
        }
    }
    else
    {
        if (block)
        {
            block(NO);
        }
    }
}

- (void)enableAudioSession:(BOOL)enable
{
    if (enable)
    {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
    }
    else
    {
        [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    }
}

- (void)interrupted:(NSNotification *)notification
{
    [self stopRecord];
}

- (void)routeChanged:(NSNotification *)notification
{
    [self stopRecord];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)playButtonClicked:(id)sender
{
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[(AVURLAsset *)_asset URL] error:nil];
    [_player play];
}

#pragma mark - record
- (void)startRecord
{
    if (_recorder)
    {
        [_recorder deleteRecording];
    }
    
    /*
     enum {
     kAudioFormatLinearPCM      = 'lpcm',
     kAudioFormatAppleIMA4      = 'ima4',
     kAudioFormatMPEG4AAC       = 'aac ',
     kAudioFormatULaw           = 'ulaw',
     kAudioFormatALaw           = 'alaw',
     kAudioFormatAppleLossless  = 'alac'
     };
     */
    NSDictionary *settings = @{
                               AVNumberOfChannelsKey : @(1),
                               AVSampleRateKey : @(8000),
                               AVLinearPCMBitDepthKey : @(16),
                               AVFormatIDKey : @(kAudioFormatMPEG4AAC),
                               };
    
    NSError *error = nil;
    //NSTemporaryDirectory()可以获取app沙箱内临时文件夹的路径，关于沙箱后面的课程会讲到
    //这里只要理解这个方法可以获取临时文件夹的路径就好了
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tempRecord.aac"];
    _recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:filePath] settings:settings error:&error];
    _recorder.delegate = self;
    _recorder.meteringEnabled = YES;
    [_recorder record];
    [self startWave];
}

- (void)stopRecord
{
    [_recorder stop];
    [self stopWave];
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    _asset = [AVAsset assetWithURL:recorder.url];
    CMTime duration = _asset.duration;
    NSLog(@"record finished totally %lf seconds",CMTimeGetSeconds(duration));
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    //handle error
}

- (void)startWave
{
    [_waveView start];
    _recordTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(recordTimerInvoke:) userInfo:nil repeats:YES];
}

- (void)stopWave
{
    [_waveView stop];
    [_recordTimer invalidate];
}

- (void)recordTimerInvoke:(NSTimer *)timer
{
    float power = 0.0;
    if ([_recorder isRecording])
    {
        [_recorder updateMeters];
        power = [_recorder peakPowerForChannel:0];
    }
    power = pow(10, (0.05 * power));
    _waveView.power = power;
}

#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_recorder.isRecording)
    {
        [self stopRecord];
    }
    else
    {
        [self startRecord];
    }
}
@end