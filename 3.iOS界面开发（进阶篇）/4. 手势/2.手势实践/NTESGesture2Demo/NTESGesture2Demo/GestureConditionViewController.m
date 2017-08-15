//
//  GestureConditionViewController.m
//  Gesture2Demo
//
//  Created by jeunfung on 16/9/28.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "GestureConditionViewController.h"

@interface GestureConditionViewController()<UIGestureRecognizerDelegate>
{
    UIView *_superView;
    UIView *_subView;
    UITapGestureRecognizer *_tap;
    
}

@end


@implementation GestureConditionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
 
    _superView = [[UIView alloc] init];
    _superView.backgroundColor = [UIColor lightGrayColor];
    _superView.frame = CGRectMake(50, 50, 200, 200);
    [self.view addSubview:_superView];
    
    _subView = [[UIView alloc] init];
    _subView.backgroundColor = [UIColor orangeColor];
    _subView.frame = CGRectMake(20, 20, 100, 100);
    [_superView addSubview:_subView];
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    _tap.delegate = self;
    [_superView addGestureRecognizer:_tap];
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == _tap)
    {
        CGPoint location = [gestureRecognizer locationInView:_superView];
        if (CGRectContainsPoint(_subView.frame, location))
        {
            return NO;
        }
        
        return YES;
    }
    
    return YES;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    if (gestureRecognizer == _tap)
//    {
//        if (touch.view != _superView && [touch.view isDescendantOfView:_superView])
//        {
//            return NO;
//        }
//        return YES;
//    }
//    
//    return YES;
//}


- (void)tap:(UITapGestureRecognizer *)gesture
{
    [self alertMessage:@"Tap"];
}

- (void)alertMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}



@end
