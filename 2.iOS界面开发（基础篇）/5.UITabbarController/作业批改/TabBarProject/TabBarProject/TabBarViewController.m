//
//  TabBarViewController.m
//  TabBarProject
//
//  Created by huangchenpeng on 2017/6/3.
//  Copyright © 2017年 ChamberH. All rights reserved.
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
    // Do any additional setup after loading the view.
    FirstViewController *first = [[FirstViewController alloc] init];
    SecondViewController *second = [[SecondViewController alloc] init];
    ThirdViewController *third = [[ThirdViewController alloc] init];
    FourthViewController *fourth = [[FourthViewController alloc] init];
    FifthViewController *fifth = [[FifthViewController alloc] init];
    
     self.viewControllers = @[ first, second, third, fourth, fifth ];
    
    UIImage *normalImage1 =  [[UIImage imageNamed:@"tab_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectedImage1 =  [[UIImage imageNamed:@"tab_home_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *normalImage2 =  [[UIImage imageNamed:@"tab_activity"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectedImage2 =  [[UIImage imageNamed:@"tab_activity_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *normalImage3 =  [[UIImage imageNamed:@"tab_sort"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectedImage3 =  [[UIImage imageNamed:@"tab_sort_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *normalImage4 =  [[UIImage imageNamed:@"tab_cart"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectedImage4 =  [[UIImage imageNamed:@"tab_cart_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *normalImage5 =  [[UIImage imageNamed:@"tab_mine"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectedImage5 =  [[UIImage imageNamed:@"tab_mine_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    first.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:normalImage1 selectedImage:selectedImage1];
    second.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"活动" image:normalImage2 selectedImage:selectedImage2];
    third.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:normalImage3 selectedImage:selectedImage3];
    fourth.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物车" image:normalImage4 selectedImage:selectedImage4];
    fifth.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的考拉" image:normalImage5 selectedImage:selectedImage5];
    
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor:[UIColor colorWithWhite:0.0f alpha:0.750f]];
    [shadow setShadowOffset:CGSizeMake(0.0f, 1.0f)];
    
    NSDictionary *tabBarTitleTextAttributesNormal = @{ NSForegroundColorAttributeName:[UIColor grayColor], NSShadowAttributeName: shadow };
    NSDictionary *tabBarTitleTextAttributesSelect = @{ NSForegroundColorAttributeName:[UIColor redColor], NSShadowAttributeName: shadow };
    for (UIViewController *vc in self.viewControllers) {
        [vc.tabBarItem setTitleTextAttributes:tabBarTitleTextAttributesNormal forState:UIControlStateNormal];
        [vc.tabBarItem setTitleTextAttributes:tabBarTitleTextAttributesSelect forState:UIControlStateSelected];
    }
    
    second.tabBarItem.badgeValue = @"";
    
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
