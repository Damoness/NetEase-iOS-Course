//
//  ViewController.m
//  1.首页导航栏
//
//  Created by wd on 2017/5/27.
//  Copyright © 2017年 ditiy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //[self.navigationController.navigationBar setBarTintColor:[UIColor grayColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    
    

    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"scan"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemPressed:)];
    
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"info"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonItemPressed:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
    
    UITextField *inputTextField = [[ UITextField alloc]initWithFrame:CGRectMake(0, 0, 250, 30)];
    inputTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    
    inputTextField.textColor = [UIColor colorWithRed:67.0/255.0 green:67.0/255.0 blue:67.0/255.0 alpha:1];
    inputTextField.font = [UIFont systemFontOfSize:14.0];
    
    inputTextField.leftViewMode = UITextFieldViewModeAlways;
    inputTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"在千万海外商品中搜索" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithRed:67.0/255.0 green:67.0/255.0 blue:67.0/255.0 alpha:1]}];

    inputTextField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search"]];
    
    inputTextField.backgroundColor = [UIColor colorWithRed:233/252.0 green:234/255.0 blue:236/255.0 alpha:1.0];
    
    self.navigationItem.titleView = inputTextField;
    
    
    
}

-(void)leftBarButtonItemPressed:(UIBarButtonItem *)item{
    
    UIViewController *leftVC = [UIViewController new];
    
    leftVC.title = @"扫描";
    leftVC.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:leftVC animated:YES];
}

-(void)rightButtonItemPressed:(UIBarButtonItem *)item{
    
    UIViewController *rightVC = [UIViewController new];
    
    rightVC.title = @"信息";
    rightVC.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:rightVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
