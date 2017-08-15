//
//  ViewController.m
//  Koala
//
//  Created by Lamo on 2017/5/5.
//  Copyright © 2017年 Lamo. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()<UISearchBarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //自定义导航栏左侧
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0, 20, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"扫一扫icon"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(getCamera) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //自定义中间视图
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 20)];
    titleView.backgroundColor = [UIColor grayColor];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 280, 20)];
    [searchBar setBackgroundColor:[UIColor clearColor]];
    searchBar.placeholder = @"搜索                                                        ";
    [titleView addSubview:searchBar];
    //添加到titleView
    self.navigationItem.titleView = titleView;
    
    //自定义导航栏右侧
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtn setFrame:CGRectMake(0, 0, 20, 20)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"消息中心入口"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(getMessage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    

}

- (void)getCamera
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的相机功能好像有问题" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)getMessage
{
    NextViewController *nextViewController = [[NextViewController alloc] init];
    
    [self.navigationController pushViewController:nextViewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goNext:(id)sender
{
    NextViewController *nextViewController = [[NextViewController alloc] init];
    
    [self.navigationController pushViewController:nextViewController animated:YES];
}

@end
