//
//  TabBarViewController.m
//  TabBarWork
//
//  Created by lusuihao-mac on 2017/5/16.
//  Copyright © 2017年 lusuihao-mac. All rights reserved.
//

#import "TabBarViewController.h"
#import "UITabBar+badge.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor* titleColor = [UIColor colorWithRed:223.0f/255.0f green:26.0f/255.0f blue:59.0f/255.0f alpha:1.0f];
    [self.tabBar setTintColor:titleColor];
    [self.viewControllers objectAtIndex:1].tabBarItem = [[UITabBarItem alloc]initWithTitle:@"活动" image:[[UIImage imageNamed:@"tab_activity"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_activity_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.tabBar showBadgeAtIndex:1];
    
//    默认小红点过大 颜色无法自定义
//    [self.viewControllers objectAtIndex:1].tabBarItem.badgeValue = @" ";
//    [self.viewControllers objectAtIndex:1].tabBarItem.badgeColor = titleColor;
    [self.viewControllers objectAtIndex:2].tabBarItem = [[UITabBarItem alloc]initWithTitle:@"分类" image:[[UIImage imageNamed:@"tab_sort"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_sort_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    
    
    
    [self.viewControllers objectAtIndex:3].tabBarItem = [[UITabBarItem alloc]initWithTitle:@"购物车" image:[[UIImage imageNamed:@"tab_cart"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_cart_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.viewControllers objectAtIndex:4].tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的考拉" image:[[UIImage imageNamed:@"tab_mine"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_mine_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    // Do any additional setup after loading the view.
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
