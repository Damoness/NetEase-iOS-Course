//
//  ViewController.m
//  NTESNavi
//
//  Created by chao liu on 2017/5/18.
//  Copyright © 2017年 chao liu. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
}

- (IBAction)pushToNextController:(id)sender {
    NextViewController *nextVC =[[NextViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
