//
//  TestMediaPickerViewController.m
//  AudioPlayDemo1
//
//  Created by Chengyin on 16/8/1.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "TestMediaPickerViewController.h"

@interface TestMediaPickerViewController ()

@end

@implementation TestMediaPickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Media Picker";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self pickFromSystemMediaPicker];
}

- (void)pickFromSystemMediaPicker
{

}
@end
