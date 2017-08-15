//
//  NTESMaskLayerViewController.m
//  CALayerDemo2
//
//  Created by lujunfeng on 16/7/16.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "NTESMaskLayerViewController.h"

@interface NTESMaskLayerViewController ()

@end

@implementation NTESMaskLayerViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.navigationItem.title = @"Image Mask Layer";
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testImageMask];
    
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

- (void)testImageMask
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"chatImage.jpg"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.frame = CGRectMake(50, 50, 200, 250);
    [self.view addSubview:imageView];
    
    UIImageView *imageViewMask = [[UIImageView alloc] init];
//    imageViewMask.image = [[UIImage imageNamed:@"imageMask.png"] stretchableImageWithLeftCapWidth:54 topCapHeight:48];
#warning aware!!
    //这里需要勘误一下。录制时当时没用3x切图，所以圆角处有点模糊
    imageViewMask.image = [[UIImage imageNamed:@"imageMask.png"] stretchableImageWithLeftCapWidth:18 topCapHeight:16];
    imageViewMask.frame = imageView.bounds;
    imageView.layer.mask = imageViewMask.layer;
    
}

@end
