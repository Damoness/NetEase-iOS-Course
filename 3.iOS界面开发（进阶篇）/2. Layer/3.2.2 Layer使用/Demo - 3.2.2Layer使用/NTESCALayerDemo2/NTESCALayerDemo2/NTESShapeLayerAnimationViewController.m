//
//  NTESShapeLayerAnimationViewController.m
//  CALayerDemo2
//
//  Created by lujunfeng on 16/7/16.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "NTESShapeLayerAnimationViewController.h"

@interface NTESShapeLayerAnimationViewController ()

@end

@implementation NTESShapeLayerAnimationViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.navigationItem.title = @"Shape Layer Ani";
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testCAShapeLayerAnimation];
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

- (void)testCAShapeLayerAnimation
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(100, 100, 100, 100);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:shapeLayer.bounds];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    shapeLayer.strokeEnd = 0;
    [self.view.layer addSublayer:shapeLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3.0f;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    [shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
}


@end
