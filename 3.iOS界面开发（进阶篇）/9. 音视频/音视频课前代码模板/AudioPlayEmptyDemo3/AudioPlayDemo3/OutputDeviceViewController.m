//
//  OutputDeviceViewController.m
//  AudioPlayDemo2
//
//  Created by Chengyin on 16/8/7.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "OutputDeviceViewController.h"

@interface OutputDeviceViewController ()
{
    UILabel *_label;
}
@end

@implementation OutputDeviceViewController

- (void)dealloc
{
    
}

- (void)loadView
{
    [super loadView];
    
    _label = [[UILabel alloc] init];
    _label.frame = self.view.bounds;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.numberOfLines = 0;
    [self.view addSubview:_label];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Output Device";
    self.view.backgroundColor = [UIColor whiteColor];
}
@end