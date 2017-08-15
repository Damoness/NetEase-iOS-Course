//
//  ViewController.m
//  NavigationControllerTest
//
//  Created by CyouGuang on 17/5/31.
//  Copyright © 2017年 CyouGuang. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"First";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextButtonAction:(id)sender {
    UIViewController *next = [[NextViewController alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}


@end
