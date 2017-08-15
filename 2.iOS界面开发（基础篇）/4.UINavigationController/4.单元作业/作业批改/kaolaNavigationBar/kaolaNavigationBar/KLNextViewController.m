//
//  KLNextViewController.m
//  kaolaNavigationBar
//
//  Created by jele lam on 3/6/2017.
//  Copyright © 2017年 jele lam. All rights reserved.
//

#import "KLNextViewController.h"

@interface KLNextViewController ()

@end

@implementation KLNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"模仿考拉第二個頁面";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    UIBarButtonItem *negSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negSpaceItem.width = -10;
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"分享"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];

    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 30, 30)];
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setFrame:CGRectMake(-10, 0, 30, 30)];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [closeButton setImage:[UIImage imageNamed:@"关闭按钮"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBackItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    
    
    self.navigationItem.leftBarButtonItems = @[negSpaceItem,leftBackItem,negSpaceItem,closeItem];
    self.navigationItem.rightBarButtonItems = @[rightItem];
    // Do any additional setup after loading the view.
}


- (IBAction)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)share {
    NSLog(@"你點擊了共享按鈕 😎😎😎😎😎");
}

- (void)close {
    NSLog(@"你點擊了關閉按鈕 😎😎😎😎😎");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
