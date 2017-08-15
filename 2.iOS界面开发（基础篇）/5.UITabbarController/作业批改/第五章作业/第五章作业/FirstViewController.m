//
//  FirstViewController.m
//  第五章作业
//
//  Created by zhongcheng on 2017/6/3.
//  Copyright © 2017年 Mist. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *normalImage = [[UIImage imageNamed:@"首页normal"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:@"首页hover"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:normalImage selectedImage:selectedImage];
    [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0.0f, -5.0f)];
    
    NSDictionary *tabBarTitleTextAttributes = @{NSForegroundColorAttributeName: [UIColor redColor]};
    [self.tabBarItem setTitleTextAttributes:tabBarTitleTextAttributes forState:UIControlStateSelected];
    
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
