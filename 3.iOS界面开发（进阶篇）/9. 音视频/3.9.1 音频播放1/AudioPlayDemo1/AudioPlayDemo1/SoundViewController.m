//
//  SoundViewController.m
//  AudioPlayDemo1
//
//  Created by Chengyin on 16/7/31.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "SoundViewController.h"
#import <AudioToolbox/AudioServices.h>

@interface SoundViewController ()
{
    SystemSoundID _soundId;
}
@end

static void systemSoundPlayingFinished(  SystemSoundID       ssID,
                                       void* __nullable    clientData)
{
    NSLog(@"playingFinished.");
}

@implementation SoundViewController

- (void)dealloc
{
    [self removeSound];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Sound";
    
    [self addSound];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self playSound];
}

- (BOOL)addSound
{
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"sound" withExtension:@"mp3"];
    OSStatus result = AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(fileURL), &_soundId);
    if (result == noErr)
    {
        if ([[UIDevice currentDevice].systemVersion floatValue] < 9.0)
        {
            result = AudioServicesAddSystemSoundCompletion(_soundId, NULL, NULL, systemSoundPlayingFinished, NULL);
        }
    }
    return result == noErr;
}

- (void)removeSound
{
    if ([[UIDevice currentDevice].systemVersion floatValue] < 9.0)
    {
        AudioServicesRemoveSystemSoundCompletion(_soundId);
    }
    AudioServicesDisposeSystemSoundID(_soundId);
}

- (void)playSound
{
    if ([[UIDevice currentDevice].systemVersion floatValue] < 9.0)
    {
        AudioServicesPlaySystemSound(_soundId);
    }
    else
    {
        AudioServicesPlaySystemSoundWithCompletion(_soundId, ^{
            NSLog(@"playingFinished 2.");
        });
    }
}
@end
