//
//  CustomNavigationControllerDelegate.m
//  NTESViewController2Demo
//
//  Created by jeunfung on 16/11/3.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "CustomNavigationControllerDelegate.h"
#import "TransformAnimation.h"
#import "PresentAnimation.h"

@implementation CustomNavigationControllerDelegate
{
    UIPercentDrivenInteractiveTransition *_innerPercentTransition;
    
    BOOL _underInteracting;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop)
    {
        return [[TransformAnimation alloc] init];
    }
//    else if (operation == UINavigationControllerOperationPush)
//    {
//        return [[PresentAnimation alloc] init];
//    }
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if (_underInteracting)
    {
        return _innerPercentTransition;
    }
    
    return nil;
}

- (void)setNavigationController:(UINavigationController *)navigationController
{
    _navigationController = navigationController;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [_navigationController.view addGestureRecognizer:panGesture];
}

- (void)pan:(id)sender
{
    if ([sender isKindOfClass:[UIPanGestureRecognizer class]])
    {
        UIPanGestureRecognizer *panGesture = sender;
        
        switch (panGesture.state) {
            case UIGestureRecognizerStateBegan:
            {
                _underInteracting = YES;
                
                _innerPercentTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
                
                if ([_navigationController.viewControllers count] > 1)
                {
                    [_navigationController popViewControllerAnimated:YES];
                }
                break;
            }
                
            case UIGestureRecognizerStateChanged:
            {
                CGPoint translationPoint = [panGesture translationInView:_navigationController.view];
                CGFloat progress = translationPoint.x / CGRectGetWidth(_navigationController.view.bounds);
                
                [_innerPercentTransition updateInteractiveTransition:progress];
                
                
                break;
            }
            case UIGestureRecognizerStateEnded:
            {
                _underInteracting = NO;
                
                if ([panGesture velocityInView:_navigationController.view].x > 0) {
                    [_innerPercentTransition finishInteractiveTransition];
                }
                else
                {
                    [_innerPercentTransition cancelInteractiveTransition];
                }
                _innerPercentTransition = nil;
                break;
            }
                
            default:
                [_innerPercentTransition cancelInteractiveTransition];
                _innerPercentTransition = nil;
                break;
        }
    }
}



@end
