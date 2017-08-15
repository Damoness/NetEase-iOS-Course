//
//  ButtonPointInsideViewController.m
//  EventUse_Me
//
//  Created by 吴狄 on 2017/7/11.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "ButtonPointInsideViewController.h"
#import "ButtonPointInsideView.h"
@interface ButtonPointInsideViewController ()

@end

@implementation ButtonPointInsideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ButtonPointInsideView *view = [[ButtonPointInsideView alloc] init];
    [self.view addSubview:view];
    view.frame = CGRectMake(50, 50, 200, 200);
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
