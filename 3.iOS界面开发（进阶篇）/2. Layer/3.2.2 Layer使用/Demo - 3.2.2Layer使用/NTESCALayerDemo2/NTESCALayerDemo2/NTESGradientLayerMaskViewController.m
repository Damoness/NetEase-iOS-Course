//
//  NTESGradientLayerMaskViewController.m
//  CALayerDemo2
//
//  Created by lujunfeng on 16/7/16.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "NTESGradientLayerMaskViewController.h"

@interface NTESGradientLayerMaskViewController ()

@end

@implementation NTESGradientLayerMaskViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.navigationItem.title = @"Gradient Layer - Mask";
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testGradientLayer];
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

- (void)testGradientLayer
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"nature.jpg"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.frame = CGRectMake(100, 100, 150, 100);
    [self.view addSubview:imageView];
    
    UIImageView *mirrorImageView = [[UIImageView alloc] init];
    mirrorImageView.image = imageView.image;
    mirrorImageView.contentMode = UIViewContentModeScaleAspectFill;
    mirrorImageView.transform = CGAffineTransformMakeScale(1, -1);
    mirrorImageView.bounds = imageView.bounds;
    mirrorImageView.center = CGPointMake(imageView.center.x, imageView.center.y + imageView.bounds.size.height);
    [self.view addSubview:mirrorImageView];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height);
    [gradientLayer setColors:@[(id)[UIColor clearColor].CGColor,
                               (id)[UIColor colorWithWhite:0 alpha:0.4].CGColor]];
    gradientLayer.startPoint = CGPointMake(0, 0.7);
    gradientLayer.endPoint = CGPointMake(0, 1);
    mirrorImageView.layer.mask = gradientLayer;
    
    //demo2
//    imageView.layer.mask = gradientLayer;
    
}


@end
