//
//  LoginViewController.m
//  Myblog
//
//  Created by 江宝敏 on 2017/5/25.
//  Copyright © 2017年 江宝敏. All rights reserved.
//

#import "LoginViewController.h"
#import "MyblogViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *accountTextBgImageView;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UIImageView *passwordTextBgImageView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIImageView *tipImageView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadinIndicatorView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *inputimage = [_accountTextBgImageView.image resizableImageWithCapInsets:UIEdgeInsetsMake(12, 22, 12, 22) resizingMode:UIImageResizingModeStretch];
    [_accountTextBgImageView setImage:inputimage];
    [_passwordTextBgImageView setImage:inputimage];
    
    UIImage *buttonBgImage=[_loginButton.currentBackgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(10,10,10,10) resizingMode:UIImageResizingModeStretch];
    [_loginButton setBackgroundImage:buttonBgImage forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:buttonBgImage forState:UIControlStateHighlighted];
    [_loginButton setBackgroundImage:buttonBgImage forState:UIControlStateDisabled];
    [_loginButton setTitle:@"" forState:UIControlStateDisabled];
    
    [_tipLabel setHidden:YES];
    [_tipImageView setHidden:YES];
    
    [_loadinIndicatorView stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonAction:(id)sender {
    //用户名为admin，密码为123456 通过验证
    [self.view endEditing:YES];
    [_loginButton setEnabled:NO];
    [_loadinIndicatorView startAnimating];
    [_loadinIndicatorView setAlpha:0.5f];
    
    [UIView animateWithDuration:1.f animations:^{
        [_loadinIndicatorView setAlpha:1.f];
        
    }completion:^(BOOL finished) {
        [_loadinIndicatorView stopAnimating];
        [_loginButton setEnabled:YES];
    }];

}
- (BOOL)canlogin{
    if ([_accountTextField.text isEqualToString:@"admin"] && [_passwordTextField.text isEqualToString:@"123456"] ){
        //验证成功,跳转进入我的博客页面

        [_tipImageView setHidden:YES];
        [_tipLabel setHidden:YES];
        return YES;
        
    }else {
        NSString *errorTip=@"";
        if(_accountTextField.text.length==0){
            errorTip=@"账号为空";
        }else if (_passwordTextField.text.length==0){
            errorTip=@"密码为空";
        }else{
            errorTip=@"账号或密码输入有误";
        }
        
        [_tipLabel setText:errorTip];
        [_tipImageView setHidden:NO];
        [_tipLabel setHidden:NO];
        
    }
    
    return NO;
}

- (void)showBlogViewController{
    MyblogViewController *viewcontroller= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MyblogViewController"];
    [self presentViewController:viewcontroller animated:YES completion:nil];
}

//- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//    
//}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([self canlogin]){
        return YES;
    }else{
        [self loginButtonAction:nil];
        return NO;
    }
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
