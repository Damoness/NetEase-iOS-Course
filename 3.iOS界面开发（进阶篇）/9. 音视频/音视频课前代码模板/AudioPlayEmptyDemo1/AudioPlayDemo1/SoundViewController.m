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
    
}
@end

@implementation SoundViewController

- (void)dealloc
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Sound";
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
@end
