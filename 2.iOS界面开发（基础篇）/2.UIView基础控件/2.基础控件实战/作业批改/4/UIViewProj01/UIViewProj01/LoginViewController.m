//
//  LoginViewController.m
//  UIViewProj01
//
//  Created by huangchenpeng on 2017/6/4.
//  Copyright © 2017年 ChamberH. All rights reserved.
//

#import "LoginViewController.h"
#import "MyBlogViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *inputBgImage = [_accountTextBgImageView.image resizableImageWithCapInsets:UIEdgeInsetsMake(12, 12, 12, 12) resizingMode:UIImageResizingModeStretch];
    [_accountTextBgImageView setImage:inputBgImage];
    [_passwordBgImageView setImage:inputBgImage];
    
    UIImage *buttongBgImage = [[UIImage imageNamed:@"button-green"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    [_loginButton setBackgroundImage:buttongBgImage forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:buttongBgImage forState:UIControlStateHighlighted];
    [_loginButton addTarget:self action:@selector(loginbuttonAction:) forControlEvents:UIControlEventTouchUpInside];
    _tipLabel.hidden = YES;
    _tipImageView.hidden = YES;
    _loadingIndicatorView.hidesWhenStopped = YES;
    [_loadingIndicatorView stopAnimating];
}


- (void)loginbuttonAction:(UIButton *)sender{
    
    //NSLog(@"test");
    [self.view endEditing:YES];
    [_loadingIndicatorView startAnimating];
    _loadingIndicatorView.alpha = 0.5;
    [UIView animateWithDuration:1.0 animations:^{
        _loadingIndicatorView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [_loadingIndicatorView stopAnimating];
        if ([_accountTextField.text isEqualToString:@"1"] && [_passwordTextField.text isEqualToString:@"2"]) {
            _tipLabel.hidden = YES;
            _tipImageView.hidden = YES;
            
            MyBlogViewController*vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"blogViewController"];
            
            
           // MyBlogViewController *vc = [[MyBlogViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }
        else{
            NSString *errorTip = @"";
            if (_accountTextField.text.length == 0) {
                errorTip = @"请输入用户名";
            } else if (_passwordTextField.text.length == 0) {
                errorTip = @"请输入密码";
            }
            else{
                errorTip = @"用户名或密码错误";
            }
            _tipLabel.hidden = NO;
            _tipImageView.hidden = NO;
            _tipLabel.text = errorTip;
        }
    } ];
    

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
