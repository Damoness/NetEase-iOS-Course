//
//  FirstViewController.m
//  TabBarWork
//
//  Created by lusuihao-mac on 2017/5/16.
//  Copyright © 2017年 lusuihao-mac. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIImage* deselectImage = [[UIImage imageNamed:@"tab_home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* selectedImage = [[UIImage imageNamed:@"tab_home_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem * tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:deselectImage selectedImage:selectedImage];
//    NSShadow * shadow = [[NSShadow alloc]init];
//    [shadow setShadowColor:[UIColor colorWithWhite:0.0f alpha:0.750f]];
//    [shadow setShadowOffset:CGSizeMake(0.0f, 1.0f)];
//    NSDictionary *tabBarTitleTextAttributes = @{NSForegroundColorAttributeName: [UIColor redColor],NSShadowAttributeName:shadow};
//    [tabBarItem setTitleTextAttributes:tabBarTitleTextAttributes forState:UIControlStateNormal];
    self.tabBarItem = tabBarItem;

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
