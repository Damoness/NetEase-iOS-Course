//
//  AVPlayerViewController.m
//  AudioPlayDemo2
//
//  Created by Chengyin on 16/7/31.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "AVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Song.h"

@interface AVPlayerViewController ()
{
    AVPlayer *_audioPlayer;
    NSArray<Song *> *_songs;
    id _timeObserver;
}

@property (nonatomic,strong) IBOutlet UIImageView *coverImageView;
@property (nonatomic,strong) IBOutlet UILabel *songNameLabel;
@property (nonatomic,strong) IBOutlet UILabel *artistAlbumLabel;
@property (nonatomic,strong) IBOutlet UILabel *bufferedLabel;
@property (nonatomic,strong) IBOutlet UISlider *progressSlider;
@property (nonatomic,strong) IBOutlet UIButton *playPauseButton;
@property (nonatomic,strong) IBOutlet UIButton *previousButton;
@property (nonatomic,strong) IBOutlet UIButton *nextButton;

@property (nonatomic,strong) Song *currentSong;
@end

@implementation AVPlayerViewController

- (void)dealloc
{
    [self disposePlayer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"AVPlayer";
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
    if ([[MPMediaLibrary class] respondsToSelector:@selector(requestAuthorization:)])
    {
        [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
            if (status == MPMediaLibraryAuthorizationStatusAuthorized)
            {
                //在课程演示中我们这里是直接加载歌曲的，但在实际开发过程中可能会因为歌曲众多而阻塞主线程
                //所以需要放到子线程中加载，线程方面的具体知识后面的课程会有涉及
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
    //在子线程加载歌曲
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
    
    //在线歌曲，这个URL可能已经不可用了，请自行填入URL
    Song *song = [[Song alloc] initWithURL:[NSURL URLWithString:@"http://mp3.freesoundtrackmusic.com/intimate_luxury-rick_dickert_CLIP.mp3"] name:@"在线歌曲" artist:nil album:nil];
    [songs insertObject:song atIndex:0];
    
    _songs = [songs copy];
    
    //加载歌曲完毕回到主线程继续操作
    [self performSelectorOnMainThread:@selector(loadSongsFinished) withObject:nil waitUntilDone:YES];
}

- (void)loadSongsFinished
{
    //加载歌曲完毕回到主线程播放
    self.currentSong = [_songs firstObject];
    [self playCurrentSong];
}


#pragma mark - current song
- (void)setCurrentSong:(Song *)currentSong
{
    _currentSong = currentSong;
    [self updateSong];
}

- (void)playCurrentSong
{
    [self createPlayer];
    [self updateProgress];
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


- (void)play
{
    [_audioPlayer play];
}

- (void)pause
{
    [_audioPlayer pause];
}

- (void)stop
{
    [_audioPlayer pause];
}

#pragma mark - create & dispose player
- (void)createPlayer
{
    if (!self.currentSong)
    {
        return;
    }
    
    [self disposePlayer];
    _audioPlayer = [AVPlayer playerWithPlayerItem:[AVPlayerItem playerItemWithAsset:self.currentSong.asset]];
    [_audioPlayer addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
    [_audioPlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_audioPlayer addObserver:self forKeyPath:@"currentItem.status" options:NSKeyValueObservingOptionNew context:nil];
    [_audioPlayer addObserver:self forKeyPath:@"currentItem.loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(currentItemFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)disposePlayer
{
    [_audioPlayer pause];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [_audioPlayer removeObserver:self forKeyPath:@"rate"];
    [_audioPlayer removeObserver:self forKeyPath:@"status"];
    [_audioPlayer removeObserver:self forKeyPath:@"currentItem.status"];
    [_audioPlayer removeObserver:self forKeyPath:@"currentItem.loadedTimeRanges"];
    _audioPlayer = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (object == _audioPlayer)
    {
        if ([keyPath isEqualToString:@"rate"])
        {
            [self updatePlayPauseState];
        }
        else if ([keyPath isEqualToString:@"status"])
        {
            AVPlayerStatus status = [change[NSKeyValueChangeNewKey] integerValue];
            if (status == AVPlayerStatusReadyToPlay)
            {
                [_audioPlayer play];
            }
            else if (status == AVPlayerStatusFailed)
            {
                //handle error
            }
        }
        else if ([keyPath isEqualToString:@"currentItem.status"])
        {
            AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] integerValue];
            if (status == AVPlayerItemStatusReadyToPlay)
            {
                [_audioPlayer play];
            }
            else if (status == AVPlayerItemStatusFailed)
            {
                //handle error
            }
        }
        else if ([keyPath isEqualToString:@"currentItem.loadedTimeRanges"])
        {
            [self updateBufferedProgress];
        }
    }
}

- (void)currentItemFinished:(NSNotification *)notification
{
    if (notification.object == _audioPlayer.currentItem)
    {
        [self playNextSong];
    }
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
        NSTimeInterval duration = CMTimeGetSeconds(_audioPlayer.currentItem.duration);
        if (duration > 0)
        {
            NSTimeInterval currentTime = CMTimeGetSeconds(_audioPlayer.currentTime);
            self.progressSlider.value = currentTime / duration;
        }
        else
        {
            self.progressSlider.value = 0;
        }
    }
}

- (void)updatePlayPauseState
{
    if (_audioPlayer.rate > 0)
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

- (void)updateBufferedProgress
{
    NSArray *loadedTimeRanges = _audioPlayer.currentItem.loadedTimeRanges;
    CMTimeRange timeRange = [[loadedTimeRanges lastObject] CMTimeRangeValue];
    CMTime bufferedTime = CMTimeAdd(timeRange.start, timeRange.duration);
    NSTimeInterval time = CMTimeGetSeconds(bufferedTime);
    NSTimeInterval duration = CMTimeGetSeconds(_audioPlayer.currentItem.duration);
    float bufferedProgress = 0;
    if (duration != 0)
    {
        bufferedProgress = time / duration;
    }
    _bufferedLabel.text = [NSString stringWithFormat:@"%.2f%%",bufferedProgress * 100];
}

#pragma mark - timer
- (void)startTimer
{
    __weak typeof(self)weakSelf = self;
    _timeObserver = [_audioPlayer addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, 1) queue:NULL usingBlock:^(CMTime time) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf updateProgress];
    }];
}

- (void)stopTimer
{
    [_audioPlayer removeTimeObserver:_timeObserver];
    _timeObserver = nil;
}

#pragma mark - xib actions
- (IBAction)progressSeeked:(UISlider *)sender
{
    NSTimeInterval seekTime = sender.value * CMTimeGetSeconds(_audioPlayer.currentItem.duration);
    [_audioPlayer seekToTime:CMTimeMakeWithSeconds(seekTime, 1) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

- (IBAction)playPauseButtonClicked:(id)sender
{
    if (_audioPlayer)
    {
        BOOL playing = _audioPlayer.rate > 0;
        if (playing)
        {
            [self pause];
        }
        else
        {
            [self play];
        }
    }
    else
    {
        [self playCurrentSong];
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
