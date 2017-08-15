//
//  TabBarViewController.m
//  学生成绩录入系统
//
//  Created by zhen7216 on 2017/7/7.
//  Copyright © 2017年 chenzhen. All rights reserved.
//

#import "TabBarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface TabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FirstViewController *firstVc = [[FirstViewController alloc] init];
    SecondViewController *secondVc = [[SecondViewController alloc] init];
    
    self.viewControllers = @[ firstVc, secondVc ];
    
    firstVc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"姓名" image:nil selectedImage:nil];
    secondVc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"科目" image:nil selectedImage:nil];
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
