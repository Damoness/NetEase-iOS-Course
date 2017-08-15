//
//  ViewController.m
//  navigationController
//
//  Created by lusuihao-mac on 2017/5/26.
//  Copyright © 2017年 lusuihao-mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    view.backgroundColor = [UIColor blueColor];
    self.navigationItem.titleView = view;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
