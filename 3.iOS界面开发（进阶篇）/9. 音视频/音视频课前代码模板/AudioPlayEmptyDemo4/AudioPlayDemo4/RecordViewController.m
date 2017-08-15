//
//  RecordViewController.m
//  AudioPlayDemo4
//
//  Created by Chengyin on 16/8/21.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "RecordViewController.h"

@interface RecordViewController ()
{

}
@end

@implementation RecordViewController

- (void)dealloc
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Play" style:UIBarButtonItemStylePlain target:self action:@selector(playButtonClicked:)];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Record Audio";
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)playButtonClicked:(id)sender
{

}

#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

}
@end