//
//  ViewController.m
//  Event_Me
//
//  Created by 吴狄 on 2017/7/7.
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
    
    
    
    [self testHitTest1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"VC touch began");
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"VC touch Ended");
    [super touchesBegan:touches withEvent:event];
}


-(void)testHitTest1{
    
    TestView *viewA = [TestView new];
    
    viewA.name = @"viewA";
    
    viewA.frame = CGRectMake(40, 50, 200, 200);
    
    viewA.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:viewA];
}

@end
