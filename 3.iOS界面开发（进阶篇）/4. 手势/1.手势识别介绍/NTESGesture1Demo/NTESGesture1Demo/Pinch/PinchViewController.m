//
//  PinchViewController.m
//  Gesture1Demo
//
//  Created by jeunfung on 16/8/13.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "PinchViewController.h"

@interface PinchViewController()
{
    UIView *_testView;
}

@end


@implementation PinchViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.navigationItem.title = @"Pinch";
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        _testView = [[UIView alloc] init];
        _testView.backgroundColor = [UIColor orangeColor];
        
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        [_testView addGestureRecognizer:pinchGesture];
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

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged)
    {
        _testView.transform = CGAffineTransformMakeScale(gesture.scale, gesture.scale);
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        _testView.transform = CGAffineTransformIdentity;
    }
}

@end



