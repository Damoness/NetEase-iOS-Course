//
//  LoginViewController.m
//  MyBlog
//
//  Created by 姚凯 on 2017/5/20.
//  Copyright © 2017年 姚凯. All rights reserved.
//

#import "LoginViewController.h"
#import "MyBlogViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *TipLabel;
@property (weak, nonatomic) IBOutlet UIImageView *TipImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Activity;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *buttonImage = [[UIImage imageNamed:@"button-green"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    [_loginButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:buttonImage forState:UIControlStateDisabled];
    [_loginButton setTitle:@"" forState:UIControlStateDisabled];
    
    
    UIImage *inputImage = [[UIImage imageNamed:@"bg-input"] resizableImageWithCapInsets:UIEdgeInsetsMake(12, 22, 12, 22) resizingMode:UIImageResizingModeStretch];
    [_accountTextField setBackground:inputImage];
    [_passwordTextField setBackground:inputImage];
    [_loginButton addTarget:self action:@selector (LoginButtonPressed)forControlEvents:UIControlEventTouchUpInside];
    [_TipLabel setHidden:YES];
    [_TipImage setHidden:YES];
    [_Activity stopAnimating];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)LoginButtonPressed
{
    
    [self.view endEditing:YES];
    
    [_loginButton setEnabled:NO];
    [_Activity startAnimating];
    [_Activity setAlpha:0.5f];
    [UIView animateWithDuration:1.f animations:^{
        [_Activity setAlpha:1.f];
    } completion:^(BOOL finished) {
        [_Activity stopAnimating];
    }];
    //  验证账号密码 用户名为admin 密码为test
    if([_accountTextField.text isEqualToString:@"admin"]&&[_passwordTextField.text isEqualToString:@"test"]){
    //验证成功
        [_TipLabel setHidden:YES];
        [_TipImage setHidden:YES];
        
    } else{
        NSString * errorTip =@"";
        if (_accountTextField.text.length ==0) {
            errorTip = @"请输入用户名";
        }else if(_passwordTextField.text.length ==0){
        errorTip = @"请输入密码";
        }else{
        errorTip = @"账号密码输入有误";
        }
        [_TipLabel setHidden:NO];
        [_TipImage setHidden:NO];
        [_TipLabel setText:errorTip];
    }
    [_loginButton setEnabled:YES];
    
    
    NSLog(@"点击登录成功！");
    
}


-(void)MyBlogVc
{
    MyBlogViewController * MyBlogVc =[[UIStoryboard storyboardWithName:@"main" bundle:nil]instantiateViewControllerWithIdentifier:@"blogViewController"];
    
    [self presentViewController:MyBlogVc animated:YES completion:nil];

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
