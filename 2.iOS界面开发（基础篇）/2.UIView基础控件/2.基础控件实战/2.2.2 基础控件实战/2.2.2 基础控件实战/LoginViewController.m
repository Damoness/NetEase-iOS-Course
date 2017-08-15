//
//  LoginViewController.m
//  2.2.2 基础控件实战
//
//  Created by 吴狄 on 2017/5/20.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "LoginViewController.h"
#import "MyBlogViewController.h"
@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *accountBgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordBgImageView;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@property (weak, nonatomic) IBOutlet UITextField *accountTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@property (weak, nonatomic) IBOutlet UIImageView *promptImageView;

@property (weak, nonatomic) IBOutlet UILabel *promptLabel;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initViews];
    
}

-(void)initViews{
    
    UIImage *accountBgImage = [self.accountBgImageView.image resizableImageWithCapInsets:UIEdgeInsetsMake(12, 20, 12, 20) resizingMode:UIImageResizingModeStretch];
    
    [self.accountBgImageView setImage:accountBgImage];
    
    
    
    UIImage *passwordBgImage = [self.passwordBgImageView.image resizableImageWithCapInsets:UIEdgeInsetsMake(12, 20, 12, 20) resizingMode:UIImageResizingModeStretch];
    
    [self.passwordBgImageView setImage:passwordBgImage];
    
    
    
    UIImage *loginImage = [[UIImage imageNamed:@"button-green"]resizableImageWithCapInsets:UIEdgeInsetsMake(15,15 , 15, 15) resizingMode:UIImageResizingModeStretch];
    
    [self.loginButton setBackgroundImage:loginImage forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:loginImage forState:UIControlStateDisabled];
    [self.loginButton setBackgroundImage:loginImage forState:UIControlStateHighlighted];
    
    [self.loginButton setTitle:@"" forState:UIControlStateDisabled];
    
    
    
    self.promptLabel.hidden = YES;
    self.promptImageView.hidden = YES;
    
    [self.activityIndicatorView stopAnimating];
    
    
}


- (IBAction)loginButtonPressed:(UIButton *)sender {

    
    [self.view endEditing:YES];
    [self.loginButton setEnabled:NO];
    [self.activityIndicatorView startAnimating];
    self.activityIndicatorView.alpha = 1;
    
    [UIView animateWithDuration:2.0 animations:^{
        
        self.activityIndicatorView.alpha = 0.5;
        
    } completion:^(BOOL finished) {
       
      
        [self.activityIndicatorView stopAnimating];
        [self.loginButton setEnabled:YES];
        
    }];
    

    
    

}




-(void)showMyBlogViewController{
    
    MyBlogViewController *blogVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MyBlogViewController"];
    
    [self presentViewController:blogVC animated:YES completion:nil];
    
}



-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    
    
    
    
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    
    if ([self canLogin]) {
        
        return YES;
    }else{
        
        
        [self loginButtonPressed:nil];
        
        return NO;
        
    }
    
}




-(BOOL)canLogin{
    
    
    //用户名：admin,密码：test
    if ([self.accountTextField.text isEqualToString: @"admin"] && [self.passwordTextField.text isEqualToString:@"test"]) {
        
        [self.promptImageView setHidden:YES];
        [self.promptLabel setHidden:YES];
        
        
        //登陆成功跳转
        
        return  YES;
        
        
    }else{
        
        NSString *errorTips = @"";
        
        if (self.accountTextField.text.length == 0) {
            
            errorTips = @"请输入用户名";
            
        }else if (_passwordTextField.text.length == 0){
            
            errorTips = @"请输入密码";
        }else{
            
            errorTips = @"用户名或密码错误";
        }
        
        self.promptLabel.text = errorTips;
        
        self.promptLabel.hidden = NO;
        self.promptImageView.hidden = NO;
        
        
    }
    
    return NO;
    
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
