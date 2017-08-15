//
//  TestViewController.m
//  NTESViewController2Demo
//
//  Created by jeunfung on 16/10/25.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "TestViewController.h"
#import "TestSecondViewController.h"
#import "PresentAnimation.h"
#import "DismissAnimation.h"

@interface TestViewController()<TestSecondViewControllerDelegate, UIViewControllerTransitioningDelegate>
{
    UIButton *_button;
    UITextField *_textField;

    PresentAnimation *_presentAnimation;
    DismissAnimation *_dismissAnimation;
    
    UIButton *_pushButton;
}

@end

@implementation TestViewController


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    NSUInteger mask = [super supportedInterfaceOrientations];
    if (mask == UIInterfaceOrientationMaskAll) {
        NSLog(@"mask all");
    }
    else if (mask == UIInterfaceOrientationMaskAllButUpsideDown)
    {
        NSLog(@"mask all but upsidedown");
    }
    
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
       
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interfaceOrientationChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidiShow:) name:UIKeyboardDidShowNotification object:nil];
        
        _presentAnimation = [[PresentAnimation alloc] init];
        _dismissAnimation = [[DismissAnimation alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _button = [[UIButton alloc] init];
    [_button setBackgroundColor:[UIColor orangeColor]];
    [_button setTitle:@"Present Button" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(presentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    _pushButton = [[UIButton alloc] init];
    [_pushButton setBackgroundColor:[UIColor orangeColor]];
    [_pushButton setTitle:@"Push Button" forState:UIControlStateNormal];
    [_pushButton addTarget:self action:@selector(pushButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pushButton];

    
    _textField = [[UITextField alloc] init];
    [_textField setBackgroundColor:[UIColor grayColor]];
    [_textField setText:@"text"];
    [self.view addSubview:_textField];
}

#pragma mark - notification
- (void)deviceOrientationChanged:(NSNotification *)notification
{
    NSLog(@"#1 receive device orientation change");
    NSLog(@"%@", [self descriptionForDeviceOrientation:[UIDevice currentDevice].orientation]);
    NSLog(@"%@", [self descriptionForInterfaceOrientation:[UIApplication sharedApplication].statusBarOrientation]);
    
}

- (void)interfaceOrientationChanged:(NSNotification *)notification
{
    NSLog(@"#2 receive interface orientation change");
    NSLog(@"%@", [self descriptionForDeviceOrientation:[UIDevice currentDevice].orientation]);
    NSLog(@"%@", [self descriptionForInterfaceOrientation:[UIApplication sharedApplication].statusBarOrientation]);
    
}

- (NSString *)descriptionForDeviceOrientation:(UIDeviceOrientation)deviceOrientation
{
    switch (deviceOrientation) {
        case UIDeviceOrientationPortrait:
            return @"Device Portrait";
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            return @"Device Portrait UpsideDown";
            break;
        case UIDeviceOrientationLandscapeLeft:
            return @"Device LandscapeLeft";
            break;
        case UIDeviceOrientationLandscapeRight:
            return @"Device LandscapeRight";
            break;
        default:
            break;
    }
    return @"Device orientation other";
}

- (NSString *)descriptionForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            return @"Interface Portrait";
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            return @"Interface Portrait UpsideDown";
            break;
        case UIInterfaceOrientationLandscapeLeft:
            return @"Interface LandscapeLeft";
            break;
        case UIInterfaceOrientationLandscapeRight:
            return @"Interface LandscapeRight";
            break;
        default:
            break;
    }
    return @"Interface orientation other";

}

- (void)viewDidLayoutSubviews
{
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation))
    {
        _button.frame = CGRectMake(100, 100, 150, 50);
        _textField.frame = CGRectMake(100, 300, 200, 30);
    }
    else
    {
        _button.frame = CGRectMake(100, 100, 150, 50);
        _textField.frame = CGRectMake(300, 100, 200, 30);
    }
    
    _pushButton.frame = CGRectMake(CGRectGetMinX(_button.frame), CGRectGetMaxY(_button.frame) + 20, CGRectGetWidth(_button.frame), CGRectGetHeight(_button.frame));

}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
        NSLog(@"screen bounds %@", NSStringFromCGRect([UIScreen mainScreen].bounds));
        
    }];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)keyboardDidiShow:(NSNotification *)notification
{
    NSLog(@"keyboard show, user info %@", notification.userInfo);
}

#pragma mark - button
- (void)presentButtonClicked:(id)sender
{
    TestSecondViewController *modalVC = [[TestSecondViewController alloc] initWithFromPush:NO];
    modalVC.delegate = self;
    modalVC.transitioningDelegate = self;
    
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:modalVC animated:YES completion:nil];
}

- (void)pushButtonClicked:(id)sender
{
    TestSecondViewController *pushVC = [[TestSecondViewController alloc] initWithFromPush:YES];
    [self.navigationController pushViewController:pushVC animated:YES];
}


#pragma mark - delegate
- (void)testSecondViewControllerDismiss:(TestSecondViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - transitioning delegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;
{
    if ([presented isKindOfClass:[TestSecondViewController class]])
    {
        return _presentAnimation;
    }
    return nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    if ([dismissed isKindOfClass:[TestSecondViewController class]])
    {
        return _dismissAnimation;
    }

    return nil;
}

@end
