//
//  ViewController.m
//  NTESTouch1Demo
//
//  Created by jeunfung on 16/7/26.
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
    
    //last demo
    //[self testHitTest1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"VC touch began");
    [super touchesBegan:touches withEvent:event];
}

- (void)testHitTest1
{
    TestView *viewA = [[TestView alloc] init];
    viewA.name = @"viewA";
    viewA.frame = CGRectMake(10, 50, 200, 200);
    viewA.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:viewA];
}


@end
