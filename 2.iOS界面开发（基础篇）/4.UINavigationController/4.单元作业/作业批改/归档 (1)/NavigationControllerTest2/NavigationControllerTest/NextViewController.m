//
//  NextViewController.m
//  NavigationControllerTest
//
//  Created by CyouGuang on 17/5/31.
//  Copyright © 2017年 CyouGuang. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"美食-饮料清仓专场";
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    //设置为黑色
    
    UIBarButtonItem *leftBackButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBackButtonAction)];//设置返回按钮样式
    
    UIBarButtonItem *leftCloseButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"关闭按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBackButtonAction)];
    
    UIBarButtonItem *rightShareButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"分享"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.navigationItem.leftBarButtonItems = @[leftBackButton, leftCloseButton];
    self.navigationItem.rightBarButtonItems = @[rightShareButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftBackButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
