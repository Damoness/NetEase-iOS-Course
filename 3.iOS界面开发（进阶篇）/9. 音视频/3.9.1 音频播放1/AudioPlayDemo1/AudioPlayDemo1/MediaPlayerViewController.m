//
//  MediaPlayerViewController.m
//  AudioPlayDemo1
//
//  Created by Chengyin on 16/7/31.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "MediaPlayerViewController.h"
#import "MediaItemPickerController.h"
#import <MediaPlayer/MediaPlayer.h>

typedef NS_ENUM(NSUInteger, AudioPlayerMode)
{
    AudioPlayerModeRepeat,
    AudioPlayerModeSingle,
    AudioPlayerModeRandom,
};

@interface MediaPlayerViewController ()<MPMediaPickerControllerDelegate,MediaItemPickerControllerDelegate>
{
    MPMusicPlayerController *_musicPlayer;
    NSTimer *_progressTimer;
    
    AudioPlayerMode _mode;
}

@property (nonatomic,strong) IBOutlet UIImageView *coverImageView;
@property (nonatomic,strong) IBOutlet UILabel *songNameLabel;
@property (nonatomic,strong) IBOutlet UILabel *artistAlbumLabel;
@property (nonatomic,strong) IBOutlet UISlider *progressSlider;
@property (nonatomic,strong) IBOutlet UIButton *playPauseButton;
@property (nonatomic,strong) IBOutlet UIButton *previousButton;
@property (nonatomic,strong) IBOutlet UIButton *nextButton;
@property (nonatomic,strong) IBOutlet UIButton *playModeButton;
@end

@implementation MediaPlayerViewController
- (void)dealloc
{
    [self disposePlayer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Media Player";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"加载歌曲" style:UIBarButtonItemStylePlain target:self action:@selector(loadSongsClicked:)];
    
    _coverImageView.layer.borderColor = [UIColor blackColor].CGColor;
    _coverImageView.layer.borderWidth = 1;
    
    [self createPlayer];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_musicPlayer stop];
}

#pragma mark - create player
- (void)createPlayer
{
    _musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(musicPlayerPlaybackStateChanged:) name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:_musicPlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(musicPlayerItemChanged:) name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:_musicPlayer];
    [_musicPlayer beginGeneratingPlaybackNotifications];
    [self setMode:AudioPlayerModeRepeat];
}

- (void)disposePlayer
{
    [_musicPlayer endGeneratingPlaybackNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:_musicPlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:_musicPlayer];
    _musicPlayer = nil;
}

#pragma mark - mode
- (void)setMode:(AudioPlayerMode)mode
{
    _mode = mode;
    if (_mode == AudioPlayerModeRepeat)
    {
        _musicPlayer.repeatMode = MPMusicRepeatModeAll;
        _musicPlayer.shuffleMode = MPMusicShuffleModeOff;
    }
    else if (_mode == AudioPlayerModeSingle)
    {
        _musicPlayer.repeatMode = MPMusicRepeatModeOne;
        _musicPlayer.shuffleMode = MPMusicShuffleModeOff;
    }
    else if (_mode == AudioPlayerModeRandom)
    {
        _musicPlayer.repeatMode = MPMusicRepeatModeAll;
        _musicPlayer.shuffleMode = MPMusicShuffleModeSongs;
    }
    [self updatePlayerMode];
}

#pragma mark - update ui
- (void)updateSong
{
    MPMediaItem *mediaItem = _musicPlayer.nowPlayingItem;
    if (mediaItem)
    {
        _songNameLabel.text = mediaItem.title;
        _artistAlbumLabel.text = [NSString stringWithFormat:@"%@ - %@",mediaItem.artist,mediaItem.albumTitle];
        MPMediaItemArtwork *artwork = mediaItem.artwork;
        _coverImageView.image = [artwork imageWithSize:_coverImageView.bounds.size];
    }
    else
    {
        _songNameLabel.text = @"歌曲名";
        _artistAlbumLabel.text = @"歌手名 - 专辑名";
        _coverImageView.image = nil;
    }
}

- (void)updatePlaybackState
{
    BOOL playing = _musicPlayer.playbackState == MPMusicPlaybackStatePlaying;
    if (playing)
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

- (void)updateProgress
{
    if (!_progressSlider.tracking)
    {
        NSTimeInterval currentTime = _musicPlayer.currentPlaybackTime;
        NSTimeInterval duration = _musicPlayer.nowPlayingItem.playbackDuration;
        if (duration == 0)
        {
            _progressSlider.value = 0;
        }
        else
        {
            _progressSlider.value = currentTime / duration;
        }
    }
}

- (void)updatePlayerMode
{
    if (_mode == AudioPlayerModeRepeat)
    {
        [_playModeButton setTitle:@"循环播放" forState:UIControlStateNormal];
    }
    else if (_mode == AudioPlayerModeSingle)
    {
        [_playModeButton setTitle:@"单曲循环" forState:UIControlStateNormal];
    }
    else if (_mode == AudioPlayerModeRandom)
    {
        [_playModeButton setTitle:@"随机播放" forState:UIControlStateNormal];
    }
}

#pragma mark - timer
- (void)timer:(NSTimer *)timer
{
    [self updateProgress];
}

- (void)startTimer
{
    _progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    [_progressTimer fire];
}

- (void)stopTimer
{
    [_progressTimer invalidate];
}

#pragma mark - notification
- (void)musicPlayerItemChanged:(NSNotification *)notification
{
    [self updateSong];
}

- (void)musicPlayerPlaybackStateChanged:(NSNotification *)notification
{
    [self updatePlaybackState];
}

#pragma mark - select item
- (void)mediaItemPicked:(MPMediaItemCollection *)mediaItemCollection
{
    [_musicPlayer setQueueWithItemCollection:mediaItemCollection];
    [_musicPlayer play];
    [self updateSong];
}

- (void)loadSongsClicked:(id)sender
{
    [self pickFromCustomMediaPicker];
}


#pragma mark - custom picker
- (void)pickFromCustomMediaPicker
{
    MediaItemPickerController *picker = [[MediaItemPickerController alloc] init];
    picker.delegate = self;
    UINavigationController *navigation  = [[UINavigationController alloc] initWithRootViewController:picker];
    [self presentViewController:navigation animated:YES completion:nil];
}

- (void)mediaItemPicker:(MediaItemPickerController *)mediaItemPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    [self mediaItemPicked:mediaItemCollection];
}

- (void)mediaItemPickerDidCancel:(MediaItemPickerController *)mediaItemPicker
{
    NSLog(@"cancelled");
}

#pragma mark - system picker
- (void)pickFromSystemMediaPicker
{
    MPMediaPickerController *pickerController = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    pickerController.delegate = self;
    pickerController.allowsPickingMultipleItems = YES;
    pickerController.prompt = @"请选择歌曲";
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    [self mediaItemPicked:mediaItemCollection];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    NSLog(@"cancelled");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - xib actions
- (IBAction)progressSeeked:(UISlider *)sender
{
    NSTimeInterval currentTime = sender.value * _musicPlayer.nowPlayingItem.playbackDuration;
    _musicPlayer.currentPlaybackTime = currentTime;
}

- (IBAction)playPauseButtonClicked:(id)sender
{
    BOOL playing = _musicPlayer.playbackState == MPMusicPlaybackStatePlaying;
    if (playing)
    {
        [_musicPlayer pause];
    }
    else
    {
        [_musicPlayer play];
    }
}

- (IBAction)previousButtonClicked:(id)sender
{
    [_musicPlayer skipToPreviousItem];
}

- (IBAction)nextButtonClicked:(id)sender
{
    [_musicPlayer skipToNextItem];
}

- (IBAction)playModeButtonClicked:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择播放模式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    void(^alertAction)(UIAlertAction *) = ^(UIAlertAction *action) {
        if ([action.title isEqualToString:@"循环播放"])
        {
            [self setMode:AudioPlayerModeRepeat];
        }
        else if ([action.title isEqualToString:@"单曲循环"])
        {
            [self setMode:AudioPlayerModeSingle];
        }
        else if ([action.title isEqualToString:@"随机播放"])
        {
            [self setMode:AudioPlayerModeRandom];
        }
    };
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"循环播放" style:UIAlertActionStyleDefault handler:alertAction];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"单曲循环" style:UIAlertActionStyleDefault handler:alertAction];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"随机播放" style:UIAlertActionStyleDefault handler:alertAction];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
