//
//  MyTabBarController.m
//  TabBarControllerDemo
//
//  Created by ShaoweiZhang on 30/5/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "MyTabBarController.h"
#import "HomeViewController.h"
#import "ActivityViewController.h"
#import "CartViewController.h"
#import "CategoryViewController.h"
#import "ProfileViewController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = [UIColor redColor];
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
