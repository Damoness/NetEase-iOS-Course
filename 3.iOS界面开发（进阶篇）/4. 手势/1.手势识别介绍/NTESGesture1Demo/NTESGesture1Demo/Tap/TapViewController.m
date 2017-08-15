//
//  TapViewController.m
//  Gesture1Demo
//
//  Created by jeunfung on 16/8/13.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "TapViewController.h"
#import "TestView.h"

@interface TapViewController()
{
    UIView *_testView;
    
    //gesture与touch关联性时使用
//    TestView *_testView;
}

@end

@implementation TapViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.navigationItem.title = @"Tap";
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        _testView = [[UIView alloc] init];
//        _testView = [[TestView alloc] init];
        _testView.backgroundColor = [UIColor orangeColor];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_testView addGestureRecognizer:tapGesture];
        
        //演示cancelsTouchesInView
//        tapGesture.cancelsTouchesInView = NO;
        
        //演示delaysTouchesBegan
//        tapGesture.delaysTouchesBegan = YES;
        
        //演示delaysTouchesEnded
//        tapGesture.numberOfTapsRequired = 2;
//        tapGesture.delaysTouchesEnded = NO;
        
        //添加多action
//        [tapGesture addTarget:self action:@selector(tap2:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _testView.frame = CGRectMake(50, 50, 150, 150);
    [self.view addSubview:_testView];
}

- (void)tap:(UITapGestureRecognizer *)gesture
{
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"tap gesture!" preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    NSLog(@"tap gesture");
}

- (void)tap2:(UITapGestureRecognizer *)gesture
{
    NSLog(@"yyy");
}
@end
