//
//  TestSecondViewController.m
//  NTESViewController2Demo
//
//  Created by jeunfung on 16/11/2.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "TestSecondViewController.h"

@interface TestSecondViewController ()
{
    UIButton *_button;
    
    BOOL _fromPush;
}
@end

@implementation TestSecondViewController

- (instancetype)initWithFromPush:(BOOL)fromPush
{
    self = [super init];
    if (self) {
        _fromPush = fromPush;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    _button = [[UIButton alloc] init];
    [_button setBackgroundColor:[UIColor redColor]];
    [_button setFrame:CGRectMake(100, 100, 150, 50)];
    
    if (_fromPush)
    {
        [_button setTitle:@"Pop" forState:UIControlStateNormal];
    }
    else
    {
        [_button setTitle:@"Dismiss" forState:UIControlStateNormal];
    }
    
    [_button addTarget:self action:@selector(dismissButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dismissButtonClicked:(id)sender
{
    if (_fromPush)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        if ([_delegate respondsToSelector:@selector(testSecondViewControllerDismiss:)])
        {
            [_delegate testSecondViewControllerDismiss:self];
        }
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
