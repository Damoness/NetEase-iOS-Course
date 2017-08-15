//
//  H5ViewController.m
//  1.首页导航栏
//
//  Created by wd on 2017/5/28.
//  Copyright © 2017年 ditiy. All rights reserved.
//

#import "H5ViewController.h"

@interface H5ViewController ()

@end

@implementation H5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[UIImage im]
    
    
    
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    
    
    UIBarButtonItem *backItem =  [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"imgBack"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    UIBarButtonItem *noneItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    noneItem.width = -10;

    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"cancel"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    
    
    self.navigationItem.title = @"美食-饮料清仓专场";
    
    self.navigationItem.leftBarButtonItems = @[noneItem,backItem,cancelItem];
    
    self.navigationItem.rightBarButtonItem = shareItem;
}


-(void)shareAction{
    
    
    UIViewController *VC = [UIViewController new];
    
    VC.title = @"分享";
    VC.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

-(void)backAction{
    
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
