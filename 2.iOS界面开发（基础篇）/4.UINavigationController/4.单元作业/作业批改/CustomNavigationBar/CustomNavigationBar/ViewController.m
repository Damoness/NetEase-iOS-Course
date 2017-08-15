//
//  ViewController.m
//  CustomNavigationBar
//
//  Created by zhen7216 on 2017/5/14.
//  Copyright © 2017年 chenzhen. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 扫一扫
    UIBarButtonItem *leftScanItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"扫一扫icon"] style:UIBarButtonItemStylePlain target:self action:@selector(scanAction)];
    leftScanItem.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = leftScanItem;
    
    // 消息中心
    UIBarButtonItem *rightMessageItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"消息中心入口"] style:UIBarButtonItemStylePlain target:self action:@selector(enterMessage)];
    rightMessageItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightMessageItem;
    
    // 搜索栏
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 35)];
    titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleView;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300, 35)];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    textField.backgroundColor = [UIColor lightGrayColor];
    textField.placeholder = @"在千万海外商品中搜索";
    textField.delegate = self;
    
    [titleView addSubview:textField];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scanAction {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"扫一扫" message:@"确认打开摄像头" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:controller animated:YES completion:nil];
}


- (void)enterMessage {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"消息中心" message:@"确认打开联系人列表" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)clickPushNext:(id)sender {
    NextViewController *next = [[NextViewController alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
