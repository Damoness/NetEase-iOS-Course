//
//  ViewController.m
//  Navigation
//
//  Created by Willei Wang on 2017/6/3.
//  Copyright © 2017年 Willei Wang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"导航栏";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"scanicon"] style:UIBarButtonItemStylePlain target:self action:@selector(scanTip)];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"message"] style:UIBarButtonItemStylePlain target:self action:@selector(messageTip)];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    UIImageView *searchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];

    searchImageView.contentMode = UIViewContentModeScaleAspectFit;
    searchImageView.center = CGPointMake(15, 15);

    UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(35, 0, 180, 30)];
    searchTextField.placeholder = @"搜索";
    [titleView addSubview:searchImageView];
    [titleView addSubview:searchTextField];
    titleView.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.93 alpha:1.00];
    
    
    self.navigationItem.titleView = titleView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scanTip
{
    NSLog(@"扫描");
}

- (void)messageTip
{
    NSLog(@"消息");
}

@end
