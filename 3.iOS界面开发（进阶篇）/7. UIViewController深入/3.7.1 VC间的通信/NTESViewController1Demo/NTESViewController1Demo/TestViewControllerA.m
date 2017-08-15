//
//  TestViewControllerA.m
//  NTESViewController1Demo
//
//  Created by jeunfung on 16/8/27.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "TestViewControllerA.h"
#import "TestViewControllerB.h"
#import "AppDelegate.h"

@interface TestViewControllerA ()<TestViewControllerBDelegate>
{
    UILabel *_delegateLabel;
    UILabel *_blockLabel;
    UILabel *_notificationLabel;
    UILabel *_mediatorLabel;
}

@end

@implementation TestViewControllerA

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.navigationItem setTitle:@"ViewController A"];
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;

    /**
     *
     *  注意：为了演示，直接在plus模拟器上做了，没有对其他尺寸屏幕做适配
     *
     **/

    //property button
    UIButton *propertyButton = [[UIButton alloc] init];
    [propertyButton setBackgroundColor:[UIColor orangeColor]];
    [propertyButton setTitle:@"next VC (property)" forState:UIControlStateNormal];
    [propertyButton addTarget:self action:@selector(propertyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    propertyButton.frame = CGRectMake(50, 50, 200, 30);
    [view addSubview:propertyButton];
    
    //initializer button
    UIButton *initializerButton = [[UIButton alloc] init];
    [initializerButton setBackgroundColor:[UIColor orangeColor]];
    [initializerButton setTitle:@"next VC (initializer)" forState:UIControlStateNormal];
    [initializerButton addTarget:self action:@selector(initializerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    initializerButton.frame = CGRectMake(50, CGRectGetMaxY(propertyButton.frame) + 30, 200, 30);
    [view addSubview:initializerButton];
    
    //delegate button
    UIButton *delegateButton = [[UIButton alloc] init];
    [delegateButton setBackgroundColor:[UIColor orangeColor]];
    [delegateButton setTitle:@"next VC (delelgate)" forState:UIControlStateNormal];
    [delegateButton addTarget:self action:@selector(delegateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    delegateButton.frame = CGRectMake(50, CGRectGetMaxY(initializerButton.frame) + 30, 200, 30);
    [view addSubview:delegateButton];
    
    _delegateLabel = [[UILabel alloc] init];
    [_delegateLabel setBackgroundColor:[UIColor lightGrayColor]];
    [_delegateLabel setTextColor:[UIColor whiteColor]];
    [_delegateLabel setFont:[UIFont systemFontOfSize:15]];
    _delegateLabel.frame = CGRectMake(CGRectGetMaxX(delegateButton.frame) + 5, CGRectGetMinY(delegateButton.frame), 150, 30);
    [view addSubview:_delegateLabel];
    
    //block button
    UIButton *blockButton = [[UIButton alloc] init];
    [blockButton setBackgroundColor:[UIColor orangeColor]];
    [blockButton setTitle:@"next VC (block)" forState:UIControlStateNormal];
    [blockButton addTarget:self action:@selector(blockButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    blockButton.frame = CGRectMake(50, CGRectGetMaxY(delegateButton.frame) + 30, 200, 30);
    [view addSubview:blockButton];
    
    _blockLabel = [[UILabel alloc] init];
    [_blockLabel setBackgroundColor:[UIColor lightGrayColor]];
    [_blockLabel setTextColor:[UIColor whiteColor]];
    [_blockLabel setFont:[UIFont systemFontOfSize:15]];
    _blockLabel.frame = CGRectMake(CGRectGetMaxX(blockButton.frame) + 5, CGRectGetMinY(blockButton.frame), 150, 30);
    [view addSubview:_blockLabel];

    
    //notification button
    UIButton *notificationButton = [[UIButton alloc] init];
    [notificationButton setBackgroundColor:[UIColor orangeColor]];
    [notificationButton setTitle:@"next VC (notification)" forState:UIControlStateNormal];
    [notificationButton addTarget:self action:@selector(notificationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    notificationButton.frame = CGRectMake(50, CGRectGetMaxY(blockButton.frame) + 30, 200, 30);
    [view addSubview:notificationButton];

    _notificationLabel = [[UILabel alloc] init];
    [_notificationLabel setBackgroundColor:[UIColor lightGrayColor]];
    [_notificationLabel setTextColor:[UIColor whiteColor]];
    [_notificationLabel setFont:[UIFont systemFontOfSize:15]];
    _notificationLabel.frame = CGRectMake(CGRectGetMaxX(notificationButton.frame) + 5, CGRectGetMinY(notificationButton.frame), 150, 30);
    [view addSubview:_notificationLabel];

    
    //mediator button
    UIButton *mediatorButton = [[UIButton alloc] init];
    [mediatorButton setBackgroundColor:[UIColor orangeColor]];
    [mediatorButton setTitle:@"next VC (mediator)" forState:UIControlStateNormal];
    [mediatorButton addTarget:self action:@selector(mediatorButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    mediatorButton.frame = CGRectMake(50, CGRectGetMaxY(notificationButton.frame) + 30, 200, 30);
    [view addSubview:mediatorButton];
    
    _mediatorLabel = [[UILabel alloc] init];
    [_mediatorLabel setBackgroundColor:[UIColor lightGrayColor]];
    [_mediatorLabel setTextColor:[UIColor whiteColor]];
    [_mediatorLabel setFont:[UIFont systemFontOfSize:15]];
    _mediatorLabel.frame = CGRectMake(CGRectGetMaxX(mediatorButton.frame) + 5, CGRectGetMinY(mediatorButton.frame), 150, 30);
    [view addSubview:_mediatorLabel];


}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (_mediatorLabel) {
        _mediatorLabel.text = ((AppDelegate *)[UIApplication sharedApplication].delegate).sharedString;
    }
}

#pragma mark - button
- (void)propertyButtonClicked:(id)sender
{
    TestViewControllerB *viewControllerB = [[TestViewControllerB alloc] init];
    viewControllerB.property1 = @"via Property value";
    [self.navigationController pushViewController:viewControllerB animated:YES];
}

- (void)initializerButtonClicked:(id)sender
{
    TestViewControllerB *viewControllerB = [[TestViewControllerB alloc] initWithProperty1:@"via Initializer value"];
    [self.navigationController pushViewController:viewControllerB animated:YES];
}

- (void)delegateButtonClicked:(id)sender
{
    TestViewControllerB *viewControllerB = [[TestViewControllerB alloc] init];
    viewControllerB.delegate = self;
    [self.navigationController pushViewController:viewControllerB animated:YES];
}

- (void)blockButtonClicked:(id)sender
{
    TestViewControllerB *viewControllerB = [[TestViewControllerB alloc] initWithDataBlock:^(NSString *data) {
       
        _blockLabel.text = data;
        
    }];
    
    [self.navigationController pushViewController:viewControllerB animated:YES];
}

- (void)notificationButtonClicked:(id)sender
{
    TestViewControllerB *viewControllerB = [[TestViewControllerB alloc] initWithNotification];
    [self.navigationController pushViewController:viewControllerB animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationReceived:) name:TestViewControllerBNotification object:nil];
}

- (void)mediatorButtonClicked:(id)sender
{
    TestViewControllerB *viewControllerB = [[TestViewControllerB alloc] initWithMediator];
    [self.navigationController pushViewController:viewControllerB animated:YES];
}

#pragma mark - delegate
- (void)testViewControllerB:(TestViewControllerB *)testViewControllerB sendDataBack:(NSString *)data
{
    _delegateLabel.text = data;
}

#pragma mark - notification
- (void)notificationReceived:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    if ([userInfo isKindOfClass:[NSDictionary class]])
    {
        _notificationLabel.text = userInfo[@"data"];
    }
}

@end
