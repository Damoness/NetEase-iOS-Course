//
//  CAShapeLayerViewController.m
//  LayerUse_Me
//
//  Created by 吴狄 on 2017/7/6.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "CAShapeLayerViewController.h"

@interface CAShapeLayerViewController ()

@end

@implementation CAShapeLayerViewController


-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.navigationItem.title = @"Shape Layer";
        
    }
    
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [ UIColor whiteColor];
    
    
    [self testCAShapeLayerWithoutBezier];
    
}

-(void)testCAShapeLayerWithoutBezier{
    
    
    CAShapeLayer *shaperLayer = [[CAShapeLayer alloc]init];
    
    shaperLayer.strokeColor  =  [UIColor redColor].CGColor;

    shaperLayer.fillColor = [UIColor clearColor].CGColor;
    
    [self.view.layer addSublayer:shaperLayer];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, nil, 50, 200);
    CGPathAddCurveToPoint(path, nil, 100, 100, 250, 300, 300, 200);
    
    shaperLayer.path = path;
    
    
}



-(void)testCAShapeLayerWithBezier{
    
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:CGPointMake(50, 200)];
    
    [bezierPath addCurveToPoint:CGPointMake(300, 200) controlPoint1:CGPointMake(100, 100) controlPoint2:CGPointMake(250, 300)];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
    
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;

    shapeLayer.path = bezierPath.CGPath;
    
    [self.view.layer addSublayer:shapeLayer];
    
    
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
