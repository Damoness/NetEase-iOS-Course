//
//  ViewController.m
//  NetEaseTest_SimpleLog
//
//  Created by _Sharuru on 2017/6/2.
//  Copyright © 2017年 KarinoSharuru. All rights reserved.
//

#import "ViewController.h"
#import "LogViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *infoBtn;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@end

@implementation ViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor colorWithRed:23 / 255.0 green:23 / 255.0 blue:23 / 255.0 alpha:1]}];
}

#pragma mark - Actions
- (IBAction)handleLoginBtnClick:(UIButton *)sender {
    if (_accountTextField.text.length == 0 ) {
        [self showInfo:@"请输入账号"];
    } else if (_passwordTextField.text.length == 0) {
        [self showInfo:@"请输入密码"];
    } else {
        [self presentLogViewController];
    }
}

#pragma mark - Private
- (void)showInfo:(NSString *)info {
    _infoBtn.hidden = NO;
    [_infoBtn setTitle:info forState:UIControlStateNormal];
}

- (void)presentLogViewController {
    _infoBtn.hidden = YES;
    [_loginBtn setTitle:@"" forState:UIControlStateNormal];
    [_indicatorView startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_indicatorView stopAnimating];
        UINavigationController *logNav = [[UINavigationController alloc] initWithRootViewController:[[LogViewController alloc] init]];
        logNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:logNav animated:YES completion:nil];
    });
}



@end
