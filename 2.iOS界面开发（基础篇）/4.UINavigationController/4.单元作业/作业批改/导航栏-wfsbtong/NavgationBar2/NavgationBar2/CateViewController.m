//
//  CateViewController.m
//  NavgationBar2
//
//  Created by 王子通 on 2017/6/4.
//  Copyright © 2017年 王子通. All rights reserved.
//

#import "CateViewController.h"

@interface CateViewController ()

@end

@implementation CateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"美食-饮料清仓专场";
    
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 16, 16);
    [backBtn addTarget:self action:@selector(navCustomBackButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"Checkmark"] forState:UIControlStateNormal];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0, 0, 16, 16);
    [closeBtn addTarget:self action:@selector(navCustomCloseButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"CheckFail"] forState:UIControlStateNormal];
    UIBarButtonItem *closeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    
    NSArray *leftItems = @[backButtonItem,closeButtonItem];
    
    self.navigationItem.leftBarButtonItems = leftItems;
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0, 0, 16, 16);
    [shareBtn addTarget:self action:@selector(navCustomShareButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
    
}




- (void)navCustomBackButtonPressed
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navCustomCloseButtonPressed
{
    NSLog(@"关闭页面");

}

- (void)navCustomShareButtonPressed
{
    
    NSLog(@"分享");

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
