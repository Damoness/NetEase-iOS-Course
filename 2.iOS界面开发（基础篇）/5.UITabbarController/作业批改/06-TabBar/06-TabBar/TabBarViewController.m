
//
//  TabBarViewController.m
//  06-TabBar
//
//  Created by 苗冬 on 2017/5/30.
//  Copyright © 2017年 苗冬. All rights reserved.
//

#import "TabBarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"

@interface TabBarViewController ()


@end

@implementation TabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    FourthViewController *fourthVC = [[FourthViewController alloc] init];
    FifthViewController *fifthVC = [[FifthViewController alloc] init];
    self.viewControllers = @[firstVC, secondVC, thirdVC, fourthVC, fifthVC];
    
    //选中变红:
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    UIImage *firstImage = [[UIImage imageNamed:@"tab_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *firstSelectedImage = [[UIImage imageNamed:@"tab_home_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    firstVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:firstImage selectedImage:firstSelectedImage];
    
    
    UIImage * secondImage = [[UIImage imageNamed:@"tab_activity"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *secondSelectedImage = [[UIImage imageNamed:@"tab_activity_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    secondVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"活动" image:secondImage selectedImage:secondSelectedImage];
    
    UIImage *thirdImage = [[UIImage imageNamed:@"tab_sort"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *thirdSelectedImage = [[UIImage imageNamed:@"tab_sort_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    thirdVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:thirdImage selectedImage:thirdSelectedImage];
    
    UIImage *fourthImage = [[UIImage imageNamed:@"tab_cart"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *fourthSelectedImage = [[UIImage imageNamed:@"tab_cart_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fourthVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物车" image:fourthImage selectedImage:fourthSelectedImage];
    
    UIImage *fifthImage = [[UIImage imageNamed:@"tab_mine"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *fifthSelectedImage = [[UIImage imageNamed:@"tab_mine_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fifthVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的考拉" image:fifthImage selectedImage:fifthSelectedImage];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
