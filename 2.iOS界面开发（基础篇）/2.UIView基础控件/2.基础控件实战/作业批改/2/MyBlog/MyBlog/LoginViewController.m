//
//  LoginViewController.m
//  MyBlog
//
//  Created by jele lam on 2/6/2017.
//  Copyright © 2017年 jele lam. All rights reserved.
//

#import "LoginViewController.h"
#import "MyBlogViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *accountImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIImageView *tipImageView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicatorView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *inputImage = [_accountImageView.image resizableImageWithCapInsets:UIEdgeInsetsMake(12, 22, 12, 22) resizingMode:UIImageResizingModeStretch];
    [_accountImageView setImage:inputImage];
    [_passwordImageView setImage:inputImage];
    
    UIImage *buttonBgImage = [[UIImage imageNamed:@"button-green"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    [_loginButton setBackgroundImage:buttonBgImage forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:buttonBgImage forState:UIControlStateHighlighted];
    [_loginButton setBackgroundImage:buttonBgImage forState:UIControlStateDisabled];
    [_loginButton setTitle:@"" forState:UIControlStateDisabled];
    
    [_tipLabel setHidden:YES];
    [_tipImageView setHidden:YES];
    [_loadingIndicatorView stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonPress:(id)sender {
    [self.view endEditing:YES];
    [_loginButton setEnabled:NO];
    [_loadingIndicatorView startAnimating];
    [_loadingIndicatorView setAlpha:.5f];
    [UIView animateWithDuration:1.f animations:^{
        [_loadingIndicatorView setAlpha:1.f];
    } completion:^(BOOL finished) {
        [_loadingIndicatorView stopAnimating];
        [_loginButton setEnabled:YES];
    }];
}

- (void)showMyBlogViewController {
    MyBlogViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"blogViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([self canLogin]) {
        return YES;
    } else {
        [self loginButtonPress:nil];
        return NO;
    }
}
- (BOOL)canLogin {
    if ([_accountTextField.text isEqualToString:@"admin"] && [_passwordTextField.text isEqualToString:@"test"]) {
        [_tipImageView setHidden:YES];
        [_tipLabel setHidden:YES];
        return YES;
    } else {
        NSString *errorTip = @"";
        if (_accountTextField.text.length == 0) {
            errorTip = @"請輸入用戶名";
        } else if (_passwordTextField.text.length == 0) {
            errorTip = @"請輸入密碼";
        } else {
            errorTip = @"用戶名或密碼輸入有誤";
        }
        [_tipImageView setHidden:NO];
        [_tipLabel setHidden:NO];
        [_tipLabel setText:errorTip];
        return NO;
    }
}

@end
