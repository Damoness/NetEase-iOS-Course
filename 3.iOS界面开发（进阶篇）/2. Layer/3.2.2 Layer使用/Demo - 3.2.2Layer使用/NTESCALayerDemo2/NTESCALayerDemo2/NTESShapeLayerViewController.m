//
//  NTESShapeLayerViewController.m
//  CALayerDemo2
//
//  Created by lujunfeng on 16/7/16.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "NTESShapeLayerViewController.h"

@interface NTESShapeLayerViewController ()

@end

@implementation NTESShapeLayerViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.navigationItem.title = @"Shape Layer";
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    

//    [self testCAShapeLayerWithoutBezier];
    
    [self testCAShapeLayerWithBezier];

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

- (void)testCAShapeLayerWithoutBezier
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer:shapeLayer];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 50, 200);
    CGPathAddCurveToPoint(path, nil, 100, 100, 250, 300, 300, 200);
    shapeLayer.path = path;
    CGPathRelease(path);
}


- (void)testCAShapeLayerWithBezier
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    CGPoint startPoint = CGPointMake(50, 200);
    CGPoint endPoint = CGPointMake(300, 200);
    CGPoint controlPoint1 = CGPointMake(100, 100);
    CGPoint controlPoint2 = CGPointMake(250, 300);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer:shapeLayer];

    //demo2
//    UIBezierPath *path2 = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 200, 200)];
//    shapeLayer.path = path2.CGPath;
//    [self.view.layer addSublayer:shapeLayer];
    
}


@end
