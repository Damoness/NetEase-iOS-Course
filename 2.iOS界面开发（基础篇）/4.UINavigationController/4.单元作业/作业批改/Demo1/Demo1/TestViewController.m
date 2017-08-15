//
//  TestViewController.m
//  Demo1
//
//  Created by zjw on 2017/6/4.
//  Copyright © 2017年 zjw. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"美食-饮料清仓专场";
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(back)];
    UIBarButtonItem *exitBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"关闭按钮"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(exit)];
    self.navigationItem.leftBarButtonItems = @[backBarButtonItem, exitBarButtonItem];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"分享"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(share)];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)exit {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)share {
    NSLog(@"分享");
}

@end
