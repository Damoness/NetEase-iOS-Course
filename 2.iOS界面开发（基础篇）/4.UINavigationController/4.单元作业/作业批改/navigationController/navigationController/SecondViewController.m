//
//  SecondViewController.m
//  navigationController
//
//  Created by lusuihao-mac on 2017/5/26.
//  Copyright © 2017年 lusuihao-mac. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * spaceButton1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButton1.width = -10;
    UIBarButtonItem * spaceButton2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButton2.width = -10;
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    UIBarButtonItem * closeButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"关闭按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    backButton.tintColor = [UIColor blackColor];
    closeButton.tintColor = [UIColor blackColor];
    self.navigationItem.title = @"美食-饮料清仓专场";
    UIBarButtonItem * shareButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"分享"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    shareButton.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = shareButton;
    self.navigationItem.leftBarButtonItems = @[spaceButton1,backButton,spaceButton2,closeButton];
    
    // Do any additional setup after loading the view.
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)shareAction {
    UIViewController * shareController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"sharePage"];
    [self presentViewController:shareController animated:YES completion:nil];


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
