//
//  NextViewController.m
//  CustomNavigationBar
//
//  Created by zhen7216 on 2017/5/14.
//  Copyright © 2017年 chenzhen. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) id<UIGestureRecognizerDelegate> originalDelegate;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"美食-饮料清仓专场";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 分享
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"分享"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    rightItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *negSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negSpaceItem.width = -20;
    
    // 返回
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    backItem.tintColor = [UIColor blackColor];
    
    // 关闭
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"关闭按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    leftItem.tintColor = [UIColor blackColor];
    
    self.navigationItem.leftBarButtonItems = @[negSpaceItem,backItem,  leftItem];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.originalDelegate = self.navigationController.interactivePopGestureRecognizer.delegate;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self.originalDelegate;
    self.originalDelegate = nil;
}

#pragma mark -

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareAction {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"分享" message:@"确认分享" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:controller animated:YES completion:nil];
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
