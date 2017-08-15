//
//  GesturePriorityViewController.m
//  Gesture2Demo
//
//  Created by jeunfung on 16/9/28.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "GesturePriorityViewController.h"

@interface GesturePriorityViewController()<UIGestureRecognizerDelegate>
{
    UIView *_view;
    
    UIPanGestureRecognizer *_pan;
    UISwipeGestureRecognizer *_swipe;
}

@end


@implementation GesturePriorityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _view = [[UIView alloc] init];
    _view.backgroundColor = [UIColor orangeColor];
    _view.frame = CGRectMake(50, 50, 100, 100);
    [self.view addSubview:_view];
    
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [_view addGestureRecognizer:_pan];
    
    _swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    [_view addGestureRecognizer:_swipe];
    
    //demo1
//    [_pan requireGestureRecognizerToFail:_swipe];
    
    //demo2
    _pan.delegate = self;
}

#pragma mark - delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == _pan && otherGestureRecognizer == _swipe)
    {
        return YES;
    }
    
    return NO;
}

- (void)pan:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint point = [gesture translationInView:self.view];
        _view.transform = CGAffineTransformMakeTranslation(point.x, point.y);
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        _view.transform = CGAffineTransformIdentity;
    }
}

- (void)swipe:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"swipe" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
