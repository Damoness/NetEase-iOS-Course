//
//  ViewController.m
//  AVCaptureSessionDemo
//
//  Created by Chengyin on 16/9/22.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "ViewController.h"
#import "MyCameraViewController.h"

@interface ViewController ()<MyCameraViewControllerDelegate>
{
@private
    UIImageView *_imageView;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"MyImagePickerDemo";
    
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Take Photo" style:UIBarButtonItemStylePlain target:self action:@selector(takeAction:)];
}

- (void)takeAction:(id)sender
{
    MyCameraViewController *cameraViewController = [[MyCameraViewController alloc] init];
    cameraViewController.delegate = self;
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:cameraViewController];
    [self presentViewController:navigation animated:YES completion:nil];
}

- (void)cameraViewController:(MyCameraViewController *)cameraViewController imageCaptured:(UIImage *)image
{
    _imageView.image = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
