//
//  ViewController.m
//  NavigationProject
//
//  Created by huangchenpeng on 2017/6/4.
//  Copyright © 2017年 ChamberH. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"在千万海外商品中搜索";
    self.navigationItem.titleView = searchBar;
    
     UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"扫一扫icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemPressed)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"消息中心入口"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemPressed)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)leftItemPressed{
    NSLog(@"左边扫一扫");
}

- (void)rightItemPressed{
    NSLog(@"右边消息中心入口");
    NextViewController *vc = [[NextViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
