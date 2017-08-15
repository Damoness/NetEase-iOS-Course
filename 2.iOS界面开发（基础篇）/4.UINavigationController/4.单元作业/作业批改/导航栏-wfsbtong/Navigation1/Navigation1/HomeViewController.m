//
//  HomeViewController.m
//  Navigation1
//
//  Created by 王子通 on 2017/6/4.
//  Copyright © 2017年 王子通. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UINavigationControllerDelegate,UISearchBarDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    self.navigationController.navigationBar.translucent = NO;
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 16, 16);
    [backBtn addTarget:self action:@selector(navCustomBackButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"Checkmark"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0, 0, 16, 16);
    [shareBtn addTarget:self action:@selector(navCustomShareButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
    
    
    CGRect mainViewBounds = self.navigationController.view.bounds;
    UISearchBar *customSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-120)/2), CGRectGetMinY(mainViewBounds)+22, CGRectGetWidth(mainViewBounds)-120, 40)];
    customSearchBar.delegate = self;
    customSearchBar.showsCancelButton = NO;
    customSearchBar.searchBarStyle = UISearchBarStyleMinimal;
    customSearchBar.placeholder = @"在千万海外商品中搜索";
    [self.navigationController.view addSubview: customSearchBar];
    
}
- (void)navCustomBackButtonPressed
{
    NSLog(@"扫码");

}
- (void)navCustomShareButtonPressed
{

    NSLog(@"信息");
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
