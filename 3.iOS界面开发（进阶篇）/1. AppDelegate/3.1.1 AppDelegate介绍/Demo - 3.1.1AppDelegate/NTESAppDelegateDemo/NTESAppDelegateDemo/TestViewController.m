//
//  TestViewController.m
//  NTESAppDelegateDemo
//
//  Created by jeunfung on 16/9/27.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "TestViewController.h"

@implementation TestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)applicationEnterBackground:(NSNotification *)notification
{
    NSLog(@"got!!! %s", __FUNCTION__);
}

- (void)applicationResignActive:(NSNotification *)notification
{
    NSLog(@"resign!!! %s", __FUNCTION__);
}

@end
