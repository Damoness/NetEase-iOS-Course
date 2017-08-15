//
//  HomeViewController.m
//  NavgationBar2
//
//  Created by 王子通 on 2017/6/4.
//  Copyright © 2017年 王子通. All rights reserved.
//

#import "HomeViewController.h"
#import "CateViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"首页";
    
    
    
}





- (IBAction)buttonWhenClicked:(UIButton *)sender {
    
    CateViewController *cateVC = [[CateViewController alloc] init];
    
    [self.navigationController  pushViewController:cateVC animated:YES];
    
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
