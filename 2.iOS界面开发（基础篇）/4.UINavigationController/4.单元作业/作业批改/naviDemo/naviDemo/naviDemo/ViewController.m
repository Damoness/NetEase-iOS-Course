//
//  ViewController.m
//  naviDemo
//
//  Created by 江宝敏 on 2017/6/2.
//  Copyright © 2017年 江宝敏. All rights reserved.
//

#import "ViewController.h"
#import "scanQRCodeViewController.h"
#import "drinkViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *leftButtonItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"扫一扫icon"] style:UIBarButtonItemStylePlain target:self action:@selector(scanQRCode)];
    self.navigationItem.leftBarButtonItem =leftButtonItem;
    //添加扫一扫按钮到导航栏左侧Item上
    
    UIBarButtonItem *rightButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"消息中心入口"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoDrinkView)];
    self.navigationItem.rightBarButtonItem =rightButtonItem;
    //添加消息中心入库按钮到导航栏右侧区域上
    
    UISearchBar *searchBar =[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 40, 200)];
    searchBar.placeholder=@"在千万海外商品中搜索";
    self.navigationItem.titleView =searchBar;
    //添加搜索框到titleview上
}

- (void)scanQRCode
{
    //点击扫一扫，切换到扫描二维码界面
    scanQRCodeViewController *scanview=[[scanQRCodeViewController alloc] init];
    [self.navigationController presentViewController:scanview animated:YES completion:nil];
}

- (void)gotoDrinkView
{
    //消息中心入口方法，简单起见跳转到第2题的导航栏界面
    drinkViewController *drinkview =[[drinkViewController alloc] init];
    [self.navigationController presentViewController:drinkview animated:YES completion:nil];
}

- (IBAction)gotoDrinkViewByPush:(id)sender
{
    //点击转场button，push方式进入第2题的界面
    drinkViewController *drinkview =[[drinkViewController alloc] init];
    [self.navigationController pushViewController:drinkview animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
