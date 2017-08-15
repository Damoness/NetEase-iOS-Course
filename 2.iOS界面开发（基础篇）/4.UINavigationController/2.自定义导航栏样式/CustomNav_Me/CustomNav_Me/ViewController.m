//
//  ViewController.m
//  CustomNav_Me
//
//  Created by 吴狄 on 2017/5/25.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.navigationItem.title = @"标题";
    
    
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBack"] forBarMetrics:UIBarMetricsDefault];
    
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor blueColor]];
    
    //self.navigationItem
    
    self.navigationController.navigationBar.translucent = NO;
    
    //self
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
