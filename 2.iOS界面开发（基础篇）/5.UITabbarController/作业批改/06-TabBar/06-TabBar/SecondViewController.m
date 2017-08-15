//
//  SecondViewController.m
//  06-TabBar
//
//  Created by 苗冬 on 2017/5/30.
//  Copyright © 2017年 苗冬. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarItem.badgeColor = [UIColor redColor];
    self.tabBarItem.badgeValue = @"";
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
