//
//  MyImagePreviewViewController.m
//  PhotoFrameworkDemo
//
//  Created by Chengyin on 16/9/11.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "MyImagePreviewViewController.h"

@interface MyImagePreviewViewController ()
{
    UIImageView *_imageView;
}
@end

@implementation MyImagePreviewViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Select" style:UIBarButtonItemStylePlain target:self action:@selector(selectAction:)];
    }
    return self;
}

- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selectAction:(id)sender
{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _imageView.frame = self.view.bounds;
}

- (void)tap:(id)sender
{
    self.navigationController.navigationBarHidden = !self.navigationController.navigationBarHidden;
}
@end
