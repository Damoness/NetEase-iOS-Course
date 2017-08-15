//
//  NextViewController.m
//  Koala
//
//  Created by Lamo on 2017/5/5.
//  Copyright © 2017年 Lamo. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"消息中心";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    UIBarButtonItem *leftBackItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    UIBarButtonItem *negSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negSpace.width = -15;
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"关闭按钮"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItems = @[negSpace, leftBackItem, closeItem];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"分享"] style:UIBarButtonItemStylePlain target:self action:@selector(share1)];
    self.navigationItem.rightBarButtonItem = rightItem;

}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)share1
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"分享到朋友圈" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *weChat = [UIAlertAction actionWithTitle:@"微信" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertVc addAction:cancel];
    [alertVc addAction:weChat];
    [self presentViewController:alertVc animated:YES completion:nil];
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
