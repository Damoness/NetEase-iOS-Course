//
//  CAshapeLayerMaskViewController.m
//  LayerUse_Me
//
//  Created by 吴狄 on 2017/7/6.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "CAshapeLayerMaskViewController.h"

@interface CAshapeLayerMaskViewController ()

@end

@implementation CAshapeLayerMaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    [self testCAShapeLayerMask];
}



-(void)testCAShapeLayerMask{
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 300, 300)];
    
    imageView.image = [UIImage imageNamed:@"nature.jpg"];

    
    [self.view addSubview:imageView];
    
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
    
//    shapeLayer.fillColor = [UIColor colorWithWhite:0.5 alpha:0.5].CGColor;
//    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    
    CGFloat  curveHeight = 40;

    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    
    [bezierPath addLineToPoint:CGPointMake(0, imageView.bounds.size.height - curveHeight)];
    //[bezierPath moveToPoint:CGPointMake(0, CGRectGetMaxY(imageView.bounds))];
    
    
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(imageView.bounds), CGRectGetMaxY(imageView.bounds) - curveHeight);
    
    CGPoint controlPoint1 = CGPointMake(CGRectGetMaxX(imageView.bounds)/2 - 50, CGRectGetMaxY(imageView.bounds)-10);
    
    CGPoint controlPoint2 = CGPointMake(CGRectGetMaxX(imageView.bounds)/2 + 50, CGRectGetMaxY(imageView.bounds)-10);
    
    [bezierPath addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    
    //[bezierPath addQuadCurveToPoint:endPoint controlPoint:CGPointMake(CGRectGetMaxX(imageView.bounds)/2, CGRectGetMaxY(imageView.bounds) - 10)];
    
    
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMaxX(imageView.bounds), 0)];
    
    [bezierPath closePath];

    shapeLayer.frame = imageView.bounds;
    
    shapeLayer.path = bezierPath.CGPath;
    
    
    
    imageView.layer.mask = shapeLayer;
    
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
