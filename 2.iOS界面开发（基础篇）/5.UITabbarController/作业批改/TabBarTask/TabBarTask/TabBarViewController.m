//
//  TabBarViewController.m
//  TabBarTask
//
//  Created by zhaxin on 17/6/1.
//  Copyright © 2017年 zhaxin. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarItem *first = [self.tabBar.items objectAtIndex:0];
    first.image = [[UIImage imageNamed:@"home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    first.selectedImage = [[UIImage imageNamed:@"home_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    first.title = @"首页";
    first.titlePositionAdjustment = UIOffsetMake(0, -5);
    
    UITabBarItem *second = [self.tabBar.items objectAtIndex:1];
    second.image = [[UIImage imageNamed:@"activity_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    second.selectedImage = [[UIImage imageNamed:@"activity_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    second.title = @"活动";
    second.badgeValue = @"";
    second.titlePositionAdjustment = UIOffsetMake(0, -5);
    
    UITabBarItem *third = [self.tabBar.items objectAtIndex:2];
    third.image = [[UIImage imageNamed:@"sort_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    third.selectedImage = [[UIImage imageNamed:@"sort_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    third.title = @"分类";
    third.titlePositionAdjustment = UIOffsetMake(0, -5);
    
    UITabBarItem *fourth = [self.tabBar.items objectAtIndex:3];
    fourth.image = [[UIImage imageNamed:@"cart_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fourth.selectedImage = [[UIImage imageNamed:@"cart_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fourth.title = @"购物车";
    fourth.titlePositionAdjustment = UIOffsetMake(0, -5);
    
    UITabBarItem *fifth = [self.tabBar.items objectAtIndex:4];
    fifth.image = [[UIImage imageNamed:@"kola_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fifth.selectedImage = [[UIImage imageNamed:@"kola_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fifth.title = @"我的考拉";
    fifth.titlePositionAdjustment = UIOffsetMake(0, -5);
    
    self.tabBar.tintColor = [UIColor redColor];
    self.selectedIndex = 0;
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
