//
//  NextViewController.m
//  第四章作业第二题
//
//  Created by zhongcheng on 2017/6/3.
//  Copyright © 2017年 Mist. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [backButtonItem setTintColor:[UIColor grayColor]];
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"关闭按钮"] style:UIBarButtonItemStylePlain target:self action:nil];
    [deleteItem setTintColor:[UIColor grayColor]];
    self.navigationItem.leftBarButtonItems = @[backButtonItem, deleteItem];
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"分享"] style:UIBarButtonItemStylePlain target:self action:nil];
    [shareItem setTintColor:[UIColor grayColor]];
    self.navigationItem.rightBarButtonItem = shareItem;
    
    [self.navigationItem setTitle:@"美食-饮料清仓专场"];
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
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
