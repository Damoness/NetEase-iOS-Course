//
//  TabBarViewController.m
//  HomeWork_File
//
//  Created by wd on 2017/7/23.
//  Copyright © 2017年 ditiy. All rights reserved.
//

#import "TabBarViewController.h"
#import "StudentViewController.h"
#import "SubjectViewController.h"
#import "FMDatabase.h"
#import "Record.h"
@interface TabBarViewController ()
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    [self initViews];
    
}

-(void)initViews{
    
    
    StudentViewController *studentVC = [StudentViewController new];
    SubjectViewController *subjectVC = [SubjectViewController new];
    
    
    studentVC.tabBarItem.title = @"学生";
    studentVC.tabBarItem.image = [UIImage imageNamed:@"tab_mine"];
    subjectVC.tabBarItem.title = @"课程";
    subjectVC.tabBarItem.image = [UIImage imageNamed:@"tab_activity"];
  
    
    UINavigationController *nc1 = [[UINavigationController alloc]initWithRootViewController:studentVC];
    UINavigationController *nc2 = [[UINavigationController alloc]initWithRootViewController:subjectVC];
    
    self.tabBar.backgroundColor = [UIColor orangeColor];
    
    self.viewControllers = @[nc1,nc2];
    
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
