//
//  AVPlayerViewController.m
//  AudioPlayDemo2
//
//  Created by Chengyin on 16/7/31.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "AVPlayerViewController.h"

@interface AVPlayerViewController ()
{

}

@property (nonatomic,strong) IBOutlet UIImageView *coverImageView;
@property (nonatomic,strong) IBOutlet UILabel *songNameLabel;
@property (nonatomic,strong) IBOutlet UILabel *artistAlbumLabel;
@property (nonatomic,strong) IBOutlet UILabel *bufferedLabel;
@property (nonatomic,strong) IBOutlet UISlider *progressSlider;
@property (nonatomic,strong) IBOutlet UIButton *playPauseButton;
@property (nonatomic,strong) IBOutlet UIButton *previousButton;
@property (nonatomic,strong) IBOutlet UIButton *nextButton;
@end

@implementation AVPlayerViewController

- (void)dealloc
{
    
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
}

#pragma mark - load songs
- (void)loadSongsClicked:(id)sender
{

}

#pragma mark - xib actions
- (IBAction)progressSeeked:(UISlider *)sender
{
    
}

- (IBAction)playPauseButtonClicked:(id)sender
{

}

- (IBAction)previousButtonClicked:(id)sender
{
    
}

- (IBAction)nextButtonClicked:(id)sender
{
    
}
@end
