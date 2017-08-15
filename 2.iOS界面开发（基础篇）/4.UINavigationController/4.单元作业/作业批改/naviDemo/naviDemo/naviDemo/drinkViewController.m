//
//  drinkViewController.m
//  naviDemo
//
//  Created by 江宝敏 on 2017/6/2.
//  Copyright © 2017年 江宝敏. All rights reserved.
//

#import "drinkViewController.h"

@interface drinkViewController ()

@end

@implementation drinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *backButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    UIBarButtonItem *closeButtonItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"关闭按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItems=@[backButtonItem,closeButtonItem];
    //添加返回和关闭按钮
    
    UIBarButtonItem *shareButtonItem= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"分享"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItem=shareButtonItem;
    //添加分享按钮
    
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 200)];
    label.text=@"美食饮料-清仓专场";
    self.navigationItem.titleView=label;
}

- (void)goBack
{
    //返回按钮时间处理，返回首页
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)share
{
    UILabel *sharelabel=[[UILabel alloc] initWithFrame:CGRectMake(150, 300, 200, 30)];
    [self.view addSubview:sharelabel];
    sharelabel.text=@"分享成功!!!!";
    sharelabel.textColor =[UIColor redColor];
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
