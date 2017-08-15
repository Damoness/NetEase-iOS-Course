//
//  EdgePanViewController.m
//  Gesture1Demo
//
//  Created by jeunfung on 16/8/13.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "EdgePanViewController.h"

@interface EdgePanViewController()
{
    UIView *_testView;
}

@end


@implementation EdgePanViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.navigationItem.title = @"EdgePan";
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        _testView = [[UIView alloc] init];
        _testView.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _testView.frame = CGRectMake(50, 50, 150, 150);
    [self.view addSubview:_testView];
    
    UIScreenEdgePanGestureRecognizer *edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePan:)];
    edgePanGesture.edges = UIRectEdgeRight;
    //try
//    edgePanGesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePanGesture];
}

- (void)edgePan:(UIScreenEdgePanGestureRecognizer *)gesture
{
    CGPoint translatePoint = [gesture translationInView:self.view];
    _testView.center = CGPointMake(_testView.center.x - translatePoint.x, _testView.center.y);
    [gesture setTranslation:CGPointZero inView:self.view];
}

@end
