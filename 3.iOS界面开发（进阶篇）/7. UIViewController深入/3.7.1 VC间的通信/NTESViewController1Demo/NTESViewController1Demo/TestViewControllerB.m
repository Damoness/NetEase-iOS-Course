//
//  TestViewControllerB.m
//  NTESViewController1Demo
//
//  Created by jeunfung on 16/8/27.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "TestViewControllerB.h"
#import "AppDelegate.h"

NSString *const TestViewControllerBNotification = @"TestViewControllerBNotification";

@interface TestViewControllerB ()
{
    DataBlock _dataBlock;
    
    BOOL _useNotification;  //demo
    BOOL _useMediator;      //demo
}

@end

@implementation TestViewControllerB

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.navigationItem setTitle:@"ViewController B"];
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (instancetype)initWithProperty1:(NSString *)property1Value
{
    self = [self init];
    if (self)
    {
        self.property1 = property1Value;
    }
    return self;
}

- (instancetype)initWithDataBlock:(DataBlock)dataBlock
{
    self = [self init];
    if (self) {
        
        _dataBlock = [dataBlock copy];
    }
    return self;
}

- (instancetype)initWithNotification
{
    self = [self init];
    if (self) {
        _useNotification = YES;
    }
    return self;
}

- (instancetype)initWithMediator
{
    self = [self init];
    if (self) {
        _useMediator = YES;
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
    
    //label
    UILabel *label = [[UILabel alloc] init];
    [label setBackgroundColor:[UIColor orangeColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont systemFontOfSize:15]];
    [label setFrame:CGRectMake(50, 50, 200, 30)];
    [view addSubview:label];
    
    label.text = self.property1;
    
    if (_delegate)
    {
        UIButton *notifyDelegateButton = [[UIButton alloc] init];
        [notifyDelegateButton setBackgroundColor:[UIColor orangeColor]];
        [notifyDelegateButton setTitle:@"notify delegate" forState:UIControlStateNormal];
        [notifyDelegateButton addTarget:self action:@selector(notifyDelegateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        notifyDelegateButton.frame = CGRectMake(50, 50, 200, 30);
        [view addSubview:notifyDelegateButton];
    }
    else if (_dataBlock)
    {
        UIButton *blockButton = [[UIButton alloc] init];
        [blockButton setBackgroundColor:[UIColor orangeColor]];
        [blockButton setTitle:@"notify block" forState:UIControlStateNormal];
        [blockButton addTarget:self action:@selector(blockButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        blockButton.frame = CGRectMake(50, 50, 200, 30);
        [view addSubview:blockButton];

    }
    else if (_useNotification)
    {
        UIButton *notificationButton = [[UIButton alloc] init];
        [notificationButton setBackgroundColor:[UIColor orangeColor]];
        [notificationButton setTitle:@"notify notification" forState:UIControlStateNormal];
        [notificationButton addTarget:self action:@selector(notificationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        notificationButton.frame = CGRectMake(50, 50, 200, 30);
        [view addSubview:notificationButton];
    }
    else if (_useMediator)
    {
        UIButton *mediatorButton = [[UIButton alloc] init];
        [mediatorButton setBackgroundColor:[UIColor orangeColor]];
        [mediatorButton setTitle:@"notify mediator" forState:UIControlStateNormal];
        [mediatorButton addTarget:self action:@selector(mediatorButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        mediatorButton.frame = CGRectMake(50, 50, 200, 30);
        [view addSubview:mediatorButton];

    }
}

#pragma mark - button
- (void)notifyDelegateButtonClicked:(id)sender
{
    if ([_delegate respondsToSelector:@selector(testViewControllerB:sendDataBack:)])
    {
        [_delegate testViewControllerB:self sendDataBack:@"notify delegate"];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)blockButtonClicked:(id)sender
{
    if (_dataBlock) {
        _dataBlock(@"notify Block");
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)notificationButtonClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TestViewControllerBNotification object:nil userInfo:@{@"data" : @"notification data"}];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)mediatorButtonClicked:(id)sender
{
    ((AppDelegate *)[UIApplication sharedApplication].delegate).sharedString = @"shared mediator";
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
