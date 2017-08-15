//
//  ViewController.m
//  第四章作业第一题
//
//  Created by zhongcheng on 2017/6/3.
//  Copyright © 2017年 Mist. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"扫一扫icon"] style:UIBarButtonItemStylePlain target:self action:nil];
    [leftItem setTintColor:[UIColor grayColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"消息中心入口"] style:UIBarButtonItemStylePlain target:self action:nil];
    [rightItem setTintColor:[UIColor grayColor]];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 7, 300, 30)];
    [searchTextField setPlaceholder:@"在千万海外商品中搜索"];
    [searchTextField setBackgroundColor:[UIColor lightGrayColor]];
    [searchTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [searchTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    
    [titleView addSubview:searchTextField];
    self.navigationItem.titleView = titleView;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
