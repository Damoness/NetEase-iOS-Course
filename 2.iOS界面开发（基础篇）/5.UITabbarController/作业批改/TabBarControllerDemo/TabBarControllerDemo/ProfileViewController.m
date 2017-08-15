//
//  ProfileViewController.m
//  TabBarControllerDemo
//
//  Created by ShaoweiZhang on 30/5/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

-(instancetype)init {
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的考拉" image:[UIImage imageNamed:@"tab_mine"] selectedImage:[UIImage imageNamed:@"tab_home_mine"]];
        
        self.title = @"我的考拉";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
