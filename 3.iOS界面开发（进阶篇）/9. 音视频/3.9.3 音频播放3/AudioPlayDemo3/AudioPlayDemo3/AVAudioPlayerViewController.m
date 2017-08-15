//
//  AVAudioPlayerViewController.m
//  AudioPlayDemo2
//
//  Created by Chengyin on 16/7/31.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "AVAudioPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Song.h"

@interface AVAudioPlayerViewController ()<AVAudioPlayerDelegate>
{
    AVAudioPlayer *_audioPlayer;
    
    NSArray<Song *> *_songs;
    
    NSTimer *_progressTimer;
    
    BOOL _playingWhenInterrupted;
    
    BOOL _remoteSeekForward;
    NSTimeInterval _beginSeekTime;
    NSTimeInterval _beginSeekPlayTime;
    NSTimer *_remoteSeekTimer;
    
    NSMutableArray *_remoteTargets;
    NSMutableArray<MPRemoteCommand *> *_remoteCommands;
}

@property (nonatomic,strong) IBOutlet UIImageView *coverImageView;
@property (nonatomic,strong) IBOutlet UILabel *songNameLabel;
@property (nonatomic,strong) IBOutlet UILabel *artistAlbumLabel;
@property (nonatomic,strong) IBOutlet UISlider *progressSlider;
@property (nonatomic,strong) IBOutlet UIButton *playPauseButton;
@property (nonatomic,strong) IBOutlet UIButton *previousButton;
@property (nonatomic,strong) IBOutlet UIButton *nextButton;

@property (nonatomic,strong) Song *currentSong;
@end

@implementation AVAudioPlayerViewController

- (void)dealloc
{
    [self disableAudioSession];
    [self disableRemoteControl];
    [self disposePlayer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"AVAudioPlayer";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"加载歌曲" style:UIBarButtonItemStylePlain target:self action:@selector(loadSongsClicked:)];
    
    _coverImageView.layer.borderColor = [UIColor blackColor].CGColor;
    _coverImageView.layer.borderWidth = 1;
    
    [self enableRemoteControl];
    [self enableAudioSession];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self stop];
}

#pragma mark - remote control
- (void)enableRemoteControl
{
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    _remoteTargets = [NSMutableArray array];
    _remoteCommands = [NSMutableArray array];
    
    __weak typeof(self)weakSelf = self;
    MPRemoteCommand *command = [MPRemoteCommandCenter sharedCommandCenter].playCommand;
    id target = [command addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [weakSelf play];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [_remoteTargets addObject:target];
    [_remoteCommands addObject:command];
    
    command = [MPRemoteCommandCenter sharedCommandCenter].pauseCommand;
    target = [command addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [weakSelf pause];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [_remoteTargets addObject:target];
    [_remoteCommands addObject:command];
    
    command = [MPRemoteCommandCenter sharedCommandCenter].stopCommand;
    target = [command addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [weakSelf stop];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [_remoteTargets addObject:target];
    [_remoteCommands addObject:command];
    
    command = [MPRemoteCommandCenter sharedCommandCenter].togglePlayPauseCommand;
    target = [command addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [weakSelf playPauseButtonClicked:nil];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [_remoteTargets addObject:target];
    [_remoteCommands addObject:command];
    
    command = [MPRemoteCommandCenter sharedCommandCenter].nextTrackCommand;
    target = [command addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [weakSelf playNextSong];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [_remoteTargets addObject:target];
    [_remoteCommands addObject:command];
    
    command = [MPRemoteCommandCenter sharedCommandCenter].previousTrackCommand;
    target = [command addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [weakSelf playPreviousSong];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [_remoteTargets addObject:target];
    [_remoteCommands addObject:command];
    
    command = [MPRemoteCommandCenter sharedCommandCenter].seekForwardCommand;
    target = [command addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        MPSeekCommandEvent *seekEvent = (MPSeekCommandEvent *)event;
        if (seekEvent.type == MPSeekCommandEventTypeBeginSeeking)
        {
            [weakSelf remoteSeekBegin:YES];
        }
        else if (seekEvent.type == MPSeekCommandEventTypeEndSeeking)
        {
            [weakSelf remoteSeekEnd];
        }
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [_remoteTargets addObject:target];
    [_remoteCommands addObject:command];
    
    command = [MPRemoteCommandCenter sharedCommandCenter].seekBackwardCommand;
    target = [command addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        MPSeekCommandEvent *seekEvent = (MPSeekCommandEvent *)event;
        if (seekEvent.type == MPSeekCommandEventTypeBeginSeeking)
        {
            [weakSelf remoteSeekBegin:NO];
        }
        else if (seekEvent.type == MPSeekCommandEventTypeEndSeeking)
        {
            [weakSelf remoteSeekEnd];
        }
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [_remoteTargets addObject:target];
    [_remoteCommands addObject:command];
}

- (void)remoteSeekBegin:(BOOL)forward
{
    _remoteSeekForward = forward;
    _beginSeekTime = [[NSDate date] timeIntervalSince1970];
    _beginSeekPlayTime = _audioPlayer.currentTime;
    
    _remoteSeekTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(remoteSeekTimer:) userInfo:nil repeats:YES];
}

- (void)remoteSeekEnd
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval currentPlayTime = [self updateRomoteSeek:time];
    _audioPlayer.currentTime = currentPlayTime;
    [self updateNowPlayingCenter];
    [_remoteSeekTimer invalidate];
    _remoteSeekTimer = nil;
}

- (NSTimeInterval)updateRomoteSeek:(NSTimeInterval)time
{
    NSTimeInterval interval = time - _beginSeekTime;
    NSTimeInterval currentPlayTime = _beginSeekPlayTime + interval * (_remoteSeekForward ? 1 : -1) * 60;
    [self updateProgress];
    return currentPlayTime;
}

- (void)remoteSeekTimer:(NSTimer *)timer
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    [self updateRomoteSeek:time];
}

- (void)disableRemoteControl
{
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [_remoteCommands enumerateObjectsUsingBlock:^(MPRemoteCommand * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeTarget:_remoteTargets[idx]];
    }];
    [_remoteCommands removeAllObjects];
    [_remoteTargets removeAllObjects];
}

#pragma mark - audiosession
- (void)enableAudioSession
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interrupted:) name:AVAudioSessionInterruptionNotification object:nil];
    [self activeAudioSession];
    //enableRemoteControl中有调用
    //    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

- (BOOL)activeAudioSession
{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    return [[AVAudioSession sharedInstance] setActive:YES error:nil];
}

- (void)disableAudioSession
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionInterruptionNotification object:nil];
    [[AVAudioSession sharedInstance] setActive:NO error:nil];
}

- (void)interrupted:(NSNotification *)notification
{
    AVAudioSessionInterruptionType type = [notification.userInfo[AVAudioSessionInterruptionTypeKey] unsignedIntegerValue];
    if (type == AVAudioSessionInterruptionTypeBegan)
    {
        _playingWhenInterrupted = _audioPlayer.isPlaying;
        if (_playingWhenInterrupted)
        {
            [self pause];
        }
    }
    else if (type == AVAudioSessionInterruptionTypeEnded)
    {
        AVAudioSessionInterruptionOptions option = [notification.userInfo[AVAudioSessionInterruptionOptionKey] unsignedIntegerValue];
        if (option == AVAudioSessionInterruptionOptionShouldResume && _playingWhenInterrupted)
        {
            [self performSelector:@selector(play) withObject:nil afterDelay:0.2];
        }
    }
}

#pragma mark - nowplaying center
- (void)updateNowPlayingCenter
{
    NSMutableDictionary *playingInfo = [NSMutableDictionary dictionary];
    if (self.currentSong.name)
    {
        playingInfo[MPMediaItemPropertyTitle] = self.currentSong.name;
    }
    if (self.currentSong.artist)
    {
        playingInfo[MPMediaItemPropertyArtist] = self.currentSong.artist;
    }
    if (self.currentSong.album)
    {
        playingInfo[MPMediaItemPropertyAlbumTitle] = self.currentSong.album;
    }
    if (self.currentSong.cover)
    {
        playingInfo[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:self.currentSong.cover];
    }
    playingInfo[MPMediaItemPropertyPlaybackDuration] = @(_audioPlayer.duration);
    playingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = @(_audioPlayer.currentTime);
    playingInfo[MPNowPlayingInfoPropertyPlaybackRate] = _audioPlayer.isPlaying ? @1.0 : @0.0;//如果使用了rate的话，请填写对应的rate
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = playingInfo;
}

#pragma mark - load songs
- (void)loadSongsClicked:(id)sender
{
    if ([[MPMediaLibrary class] respondsToSelector:@selector(requestAuthorization:)])
    {
        [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
            if (status == MPMediaLibraryAuthorizationStatusAuthorized)
            {
                [self performSelectorInBackground:@selector(loadSongs) withObject:nil];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:@"未允许访问音乐库" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];
    }
    else
    {
        [self performSelectorInBackground:@selector(loadSongs) withObject:nil];
    }
}

- (void)loadSongs
{
    NSMutableArray<Song *> *songs = [NSMutableArray array];
    MPMediaQuery *query = [MPMediaQuery songsQuery];
    for (MPMediaItem *item in query.items)
    {
        Song *song = [[Song alloc] initWithMediaItem:item];
        if (song)
        {
            [songs addObject:song];
        }
    }
    
    NSArray<NSString *> *localSongNames = @[@"a_moment_of_reflection-enrico_altavilla",@"intimate_luxury-rick_dickert",@"mourning-rick_dickert"];
    for (NSString *name in localSongNames)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"mp3"];
        Song *song = [[Song alloc] initWithFilePath:filePath];
        if (song)
        {
            [songs addObject:song];
        }
    }
    _songs = [songs copy];
    
    [self performSelectorOnMainThread:@selector(loadSongsFinished) withObject:nil waitUntilDone:YES];
}

- (void)loadSongsFinished
{
    self.currentSong = [_songs firstObject];
    [self playCurrentSong];
}

#pragma mark - create & dispose player
- (void)createPlayer
{
    if (!self.currentSong)
    {
        return;
    }
    
    [self disposePlayer];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[self.currentSong.asset URL] fileTypeHint:AVFileTypeMPEGLayer3 error:nil];
    _audioPlayer.delegate = self;
}

- (void)disposePlayer
{
    [self stop];
    _audioPlayer.delegate = nil;
    _audioPlayer = nil;
}

#pragma mark - change song
- (void)setCurrentSong:(Song *)currentSong
{
    _currentSong = currentSong;
    [self updateSong];
}

#pragma mark - play song
- (void)playCurrentSong
{
    [self createPlayer];
    [self play];
    [self updateProgress];
}

- (void)playPreviousSong
{
    NSUInteger index = [_songs indexOfObject:self.currentSong] - 1;
    Song *previsousSong = nil;
    if (index < _songs.count)
    {
        previsousSong = _songs[index];
    }
    else
    {
        previsousSong = [_songs lastObject];
    }
    self.currentSong = previsousSong;
    [self playCurrentSong];
}

- (void)playNextSong
{
    NSUInteger index = [_songs indexOfObject:self.currentSong] + 1;
    Song *nextSong = nil;
    if (index < _songs.count)
    {
        nextSong = _songs[index];
    }
    else
    {
        nextSong = [_songs firstObject];
    }
    self.currentSong = nextSong;
    [self playCurrentSong];
}

- (void)play
{
    if ([self activeAudioSession])
    {
        [_audioPlayer play];
    }
    [self updatePlayPauseState];
}

- (void)pause
{
    [_audioPlayer pause];
    [self updatePlayPauseState];
}

- (void)stop
{
    [_audioPlayer stop];
    [self updatePlayPauseState];
}

#pragma mark - update ui
- (void)updateSong
{
    if (_currentSong)
    {
        _songNameLabel.text = _currentSong.name;
        _artistAlbumLabel.text = [NSString stringWithFormat:@"%@ - %@",_currentSong.artist,_currentSong.album];
        _coverImageView.image = _currentSong.cover;
    }
    else
    {
        _songNameLabel.text = @"歌曲名";
        _artistAlbumLabel.text = @"歌手名 - 专辑名";
        _coverImageView.image = nil;
    }
    [self updateNowPlayingCenter];
}

- (void)updateProgress
{
    if (!_progressSlider.tracking)
    {
        NSTimeInterval duration = _audioPlayer.duration;
        if (duration > 0)
        {
            self.progressSlider.value = _audioPlayer.currentTime / duration;
        }
        else
        {
            self.progressSlider.value = 0;
        }
    }
}

- (void)updatePlayPauseState
{
    if (_audioPlayer.isPlaying)
    {
        [_playPauseButton setTitle:@"暂停" forState:UIControlStateNormal];
        [self startTimer];
    }
    else
    {
        [_playPauseButton setTitle:@"播放" forState:UIControlStateNormal];
        [self stopTimer];
    }
    [self updateNowPlayingCenter];
}

#pragma mark - player delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self playNextSong];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error
{
    //handle error
}

#pragma mark - timer
- (void)startTimer
{
    _progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    [_progressTimer fire];
}

- (void)stopTimer
{
    [_progressTimer invalidate];
}

- (void)timer:(NSTimer *)timer
{
    [self updateProgress];
}

#pragma mark - xib actions
- (IBAction)progressSeeked:(UISlider *)sender
{
    NSTimeInterval seekTime = sender.value * _audioPlayer.duration;
    if (seekTime >= _audioPlayer.duration)
    {
        [self playNextSong];
    }
    else
    {
        _audioPlayer.currentTime = seekTime;
        [self updateNowPlayingCenter];
    }
}

- (IBAction)playPauseButtonClicked:(id)sender
{
    if (!_audioPlayer)
    {
        [self playCurrentSong];
    }
    else
    {
        if (_audioPlayer.isPlaying)
        {
            [self pause];
        }
        else
        {
            [self play];
        }
    }
}

- (IBAction)previousButtonClicked:(id)sender
{
    [self playPreviousSong];
}

- (IBAction)nextButtonClicked:(id)sender
{
    [self playNextSong];
}
@end
