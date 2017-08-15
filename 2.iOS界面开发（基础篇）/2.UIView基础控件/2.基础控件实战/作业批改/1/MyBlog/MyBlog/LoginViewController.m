//
//  LoginViewController.m
//  MyBlog
//
//  Created by CyouGuang on 17/5/29.
//  Copyright © 2017年 CyouGuang. All rights reserved.
//

#import "LoginViewController.h"
#import "MyBlogViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *accountTextBgImageView;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwTextField;
@property (weak, nonatomic) IBOutlet UIImageView *pwTextBgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tipImageView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicatorView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *imputBgImage = [_accountTextBgImageView.image resizableImageWithCapInsets:UIEdgeInsetsMake(12, 22, 12, 22)resizingMode:UIImageResizingModeStretch];
    [_accountTextBgImageView setImage:imputBgImage];
    [_pwTextBgImageView setImage:imputBgImage];
    //设置账号以及密码框的背景
    
    UIImage *buttonBgImage = [[UIImage imageNamed:@"button-green"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    [_loginButton setBackgroundImage:buttonBgImage forState:UIControlStateNormal];//按钮正常时
    [_loginButton setBackgroundImage:buttonBgImage forState:UIControlStateHighlighted];//按钮被点击时
    [_loginButton setBackgroundImage:buttonBgImage forState:UIControlStateDisabled];
    [_loginButton setTitle:@"" forState:UIControlStateDisabled];
    //设置按钮背景图片
    
    [_tipLabel setHidden:YES];
    [_tipImageView setHidden:YES];
    [_loadingIndicatorView setHidden:YES];
    [_loadingIndicatorView stopAnimating];
    
    //[_loginButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];//关联点击事件!
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonAction:(id)sender {
    //登录按钮被按下事件
    [self.view endEditing:YES];//关闭键盘
    [_loginButton setEnabled:NO];//锁定按钮,防止多次点击
    [_loadingIndicatorView startAnimating];
    [_loadingIndicatorView setHidden:NO];
    [_loadingIndicatorView setAlpha:0.5f];
    //开始动画
    [UIView animateWithDuration:1.f animations:^{
        [_loadingIndicatorView setAlpha:1.f];
    } completion:^(BOOL finished){
        //动画完成!
        [_loadingIndicatorView stopAnimating];
        //用户名为admin 密码 test
        if([_accountTextField.text isEqualToString:@"admin"] && [_pwTextField.text
                                                              isEqualToString:@"test"]){
        //已经验证成功
            [self showBlogViewController];
            //进入我的博客页面喽!
        [_tipLabel setHidden:YES];
        [_tipImageView setHidden:YES];
    }else{
        //验证失败,下面是寻找错误的地方.
        NSString *errorTip = @"";
        if ([_accountTextField.text length] == 0) {
            errorTip = @"请输入账号!";
        } else if([_pwTextField.text length] == 0){
            errorTip = @"请输入密码!";
        }else{
            errorTip = @"账号或密码错误!";
        }
        [_tipLabel setHidden:NO];
        [_tipImageView setHidden:NO];
        [_tipLabel setText:errorTip];
    }
        [_loginButton setEnabled:YES];
        [_loadingIndicatorView setHidden:YES];
    }];
}
- (void)showBlogViewController{
    MyBlogViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"blogViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
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
