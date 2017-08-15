//
//  NTESShapeLayerMaskViewController.m
//  CALayerDemo2
//
//  Created by lujunfeng on 16/7/16.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "NTESShapeLayerMaskViewController.h"

@interface NTESShapeLayerMaskViewController ()

@end

@implementation NTESShapeLayerMaskViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.navigationItem.title = @"Gradient Layer - mask";
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testShapeLayerMask];
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

- (void)testShapeLayerMask
{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.frame = CGRectMake(50, 100, 300, 200);
    [self.view addSubview:bgView];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"nature.jpg"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.frame = bgView.bounds;
    [bgView addSubview:imageView];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPath];
    [maskPath moveToPoint:CGPointMake(0, 0)];
    
    CGFloat curveHeight = 40;
    CGFloat curveBeginHeight = imageView.frame.size.height - curveHeight;
    [maskPath addLineToPoint:CGPointMake(0, curveBeginHeight)];
    
    CGPoint curveEndPoint = CGPointMake(imageView.frame.size.width, imageView.frame.size.height - curveHeight);
    CGPoint controlPoint = CGPointMake(imageView.frame.size.width / 2, imageView.frame.size.height + 20);
    [maskPath addQuadCurveToPoint:curveEndPoint controlPoint:controlPoint];
    
    [maskPath addLineToPoint:CGPointMake(imageView.frame.size.width, 0)];
    [maskPath closePath];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = imageView.bounds;
    maskLayer.path = maskPath.CGPath;
    //you can try
//    [bgView.layer addSublayer:maskLayer];
    bgView.layer.mask = maskLayer;
    
    
}


@end
