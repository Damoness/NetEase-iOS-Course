//
//  LongPressViewController.m
//  Gesture1Demo
//
//  Created by jeunfung on 16/8/13.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "LongPressViewController.h"


@interface LongPressViewController()
{
    UIView *_testView;
}

@end


@implementation LongPressViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.navigationItem.title = @"LongPress";
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        _testView = [[UIView alloc] init];
        _testView.backgroundColor = [UIColor orangeColor];
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPressGesture.minimumPressDuration = 2;
        [_testView addGestureRecognizer:longPressGesture];
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

- (void)longPress:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"long press gesture!" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        
    }
}

@end
