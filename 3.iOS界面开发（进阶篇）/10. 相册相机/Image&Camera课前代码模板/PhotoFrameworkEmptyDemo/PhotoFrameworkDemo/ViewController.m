//
//  ViewController.m
//  PhotoFrameworkDemo
//
//  Created by Chengyin on 16/9/11.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "ViewController.h"
#import "MyImagePickerViewController.h"

@interface ViewController ()
{
    NSMutableArray<UIImageView *> *_imageViews;
}
@end

@implementation ViewController

#pragma mark - views
- (void)loadView
{
    [super loadView];
    
    
    CGFloat width = self.view.bounds.size.width / 2;
    CGFloat height = self.view.bounds.size.height / 2;
    _imageViews = [NSMutableArray array];
    for (int i = 0; i < 2; ++i)
    {
        for (int j = 0; j < 2; ++j)
        {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(j * width, i * height, width, height);
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.view addSubview:imageView];
            [_imageViews addObject:imageView];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"MyImagePickerDemo";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Pick" style:UIBarButtonItemStylePlain target:self action:@selector(pickAction:)];
}

- (void)pickAction:(id)sender
{
    MyImagePickerViewController *picker = [[MyImagePickerViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:picker];
    [self presentViewController:navigation animated:YES completion:nil];
}
@end
