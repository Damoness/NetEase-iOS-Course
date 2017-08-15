//
//  PanViewController.m
//  Gesture1Demo
//
//  Created by jeunfung on 16/8/13.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "PanViewController.h"

@interface PanViewController()
{
    UIView *_testView;
}

@end


@implementation PanViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.navigationItem.title = @"Pan";
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        _testView = [[UIView alloc] init];
        _testView.backgroundColor = [UIColor orangeColor];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [_testView addGestureRecognizer:panGesture];
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

- (void)pan:(UIPanGestureRecognizer *)gesture
{
    CGPoint translatePoint = [gesture translationInView:self.view];
    
    NSLog(@"%@",NSStringFromCGPoint(translatePoint));
    
//    _testView.center = CGPointMake(_testView.center.x + translatePoint.x, _testView.center.y + translatePoint.y);
    //[gesture setTranslation:CGPointZero inView:self.view];
    
    if (gesture.state == UIGestureRecognizerStatePossible)
    {
        NSLog(@"possible");
    }
    else if (gesture.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"began");
    }
    else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        NSLog(@"changed");
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"ended");
    }
}

@end
