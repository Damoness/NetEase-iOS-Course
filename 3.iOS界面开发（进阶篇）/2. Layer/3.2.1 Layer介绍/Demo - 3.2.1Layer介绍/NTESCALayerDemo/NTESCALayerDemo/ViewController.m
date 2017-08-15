//
//  ViewController.m
//  NTESCALayerDemo
//
//  Created by lujunfeng on 16/7/7.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    //【demo1.1 view.backgroundColor vs layer.backgroundColor】
//    UIView *subView1 = [[UIView alloc] init];
//    subView1.backgroundColor = [UIColor grayColor];
//    subView1.frame = CGRectMake(50, 100, 100, 100);
//    [self.view addSubview:subView1];
//    
//    UIView *subView2 = [[UIView alloc] init];
//    subView2.layer.backgroundColor = [UIColor orangeColor].CGColor;
//    subView2.layer.frame = CGRectMake(200, 100, 100, 100);
//    [self.view addSubview:subView2];
//    
//    UIView *subView3 = [[UIView alloc] init];
//    subView3.backgroundColor = subView2.backgroundColor;
//    subView3.frame = CGRectMake(200, 250, 100, 100);
//    [self.view addSubview:subView3];
    
    //demo1.2
    TestView *testView = [[TestView alloc] init];
    self.view = testView;
    
    //demo1.3
//    CALayer *layer1 = [[CALayer alloc] init];
//    layer1.backgroundColor = [UIColor orangeColor].CGColor;
//    layer1.frame = CGRectMake(100, 100, 150, 150);
//    
//    layer1.borderColor = [UIColor redColor].CGColor;
//    layer1.borderWidth = 2;
//    
//    layer1.cornerRadius = 10;
//    layer1.masksToBounds = YES;
//    
//    layer1.anchorPoint = CGPointMake(0, 0);
//    NSLog(@"layer1 position %@", NSStringFromCGPoint(layer1.position));
//    NSLog(@"layer1 frame %@", NSStringFromCGRect(layer1.frame));
//    
////    layer1.position = CGPointMake(100, 100);
//    layer1.frame = CGRectMake(100, 100, 150, 150);
//    
//    [self.view.layer addSublayer:layer1];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
