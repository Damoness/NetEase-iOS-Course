//
//  ViewController.m
//  LayerIntroduction_Me
//
//  Created by 吴狄 on 2017/7/4.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//    //demo 1.1
//    UIView *aView1 = [TestView new];
//    aView1.frame = CGRectMake(40, 40, 50, 50);
//    aView1.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:aView1];
//    
//    UIView *aView2 = [UIView new];
//    aView2.frame = CGRectMake(40, 140, 50, 50);
//    aView2.layer.backgroundColor = [UIColor blackColor].CGColor;
//    [self.view addSubview:aView2];
//
//    UIView *aView3 = [UIView new];
//    aView3.frame = CGRectMake(40, 240, 50, 50);
//    aView3.backgroundColor = aView2.backgroundColor;
//    [self.view addSubview:aView3];
    
      //demo 1.2
//    CALayer *aLayer = [CALayer new];
//    aLayer.frame = CGRectMake(100, 100, 100, 100);
//    aLayer.backgroundColor = [UIColor greenColor].CGColor;
//    aLayer.borderWidth = 2;
//    aLayer.borderColor = [UIColor blackColor].CGColor;
//    aLayer.anchorPoint = CGPointMake(0, 0);
//    aLayer.cornerRadius = 15;
//    aLayer.masksToBounds = YES;
//    
//    
//    NSLog(@"aLayer position :%@",NSStringFromCGPoint(aLayer.position));
//    NSLog(@"aLayer frame :%@",NSStringFromCGRect(aLayer.frame));
//    
//    
//    aLayer.contents = (id)[UIImage imageNamed:@"iPhone.jpg"].CGImage;
//    //aLayer.position = CGPointMake(100, 100);
//    //aLayer.frame = CGRectMake(100, 100, 150, 150);
//    
//    aLayer.transform = CATransform3DMakeRotation(M_PI / 6, 0, 0, 1);
//    
//    [self.view.layer addSublayer:aLayer];
    
    
      //demo 1.3
    UIView *view1 = [UIView new];
    view1.frame = CGRectMake(40, 50, 100, 100);
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    NSLog(@"view1 layer:%@",view1.layer);
    
    UIView *view2 = [UIView new];
    view2.frame = CGRectMake(200, 50, 100, 100);
    view2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view2];
    NSLog(@"view2 layer:%@",view2.layer);
    
    CALayer *layer1 = [CALayer new];
    layer1.frame = CGRectMake(40, 200, 100, 100);
    layer1.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:layer1];
    NSLog(@"layer1:%@",layer1);
    
    
    for (CALayer *layer in self.view.layer.sublayers) {
        
        NSLog(@"layer:%@",layer);
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
