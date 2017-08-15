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
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self stop];
}

#pragma mark - load songs
- (void)loadSongsClicked:(id)sender
{
    [self performSelectorInBackground:@selector(loadSongs) withObject:nil];
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
    [_audioPlayer play];
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