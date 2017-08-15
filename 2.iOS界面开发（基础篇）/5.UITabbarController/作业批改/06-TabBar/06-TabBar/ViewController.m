//
//  ViewController.m
//  06-TabBar
//
//  Created by 苗冬 on 2017/5/30.
//  Copyright © 2017年 苗冬. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

- (IBAction)pushToNextVC:(id)sender;

@end

@implementation ViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"viewController";
}


- (IBAction)pushToNextVC:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
