//
//  SecondViewController.m
//  NavControllerDemo
//
//  Created by Ashley Han on 27/1/2017.
//  Copyright © 2017 netease. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) id<UIGestureRecognizerDelegate> originalDelegate;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"imgBack"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClicked)];
    UIBarButtonItem *closeButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navClose"] style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonClicked)];
    
    UIBarButtonItem *shareButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navShare"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonClicked)];
    
    self.navigationItem.title = @"美食-饮料清仓专场";
    self.navigationItem.leftBarButtonItems = @[backButtonItem, closeButtonItem];
    self.navigationItem.rightBarButtonItem = shareButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.originalDelegate = self.navigationController.interactivePopGestureRecognizer.delegate;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self.originalDelegate;
}

- (void)backButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)closeButtonClicked {
    NSLog(@"closeButton is clicked");
}

- (void)shareButtonClicked {
    NSLog(@"shareButton is clicked");
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
