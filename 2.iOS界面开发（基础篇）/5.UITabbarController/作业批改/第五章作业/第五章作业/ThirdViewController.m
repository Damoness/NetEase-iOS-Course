//
//  ThirdViewController.m
//  第五章作业
//
//  Created by zhongcheng on 2017/6/3.
//  Copyright © 2017年 Mist. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIImage *normalImage = [[UIImage imageNamed:@"分类normal"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:@"分类hover"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:normalImage selectedImage:selectedImage];
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
