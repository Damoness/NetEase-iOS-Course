//
//  TransformAnimation.m
//  NTESViewController2Demo
//
//  Created by jeunfung on 16/11/3.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "TransformAnimation.h"

@implementation TransformAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [[transitionContext containerView] addSubview:toVC.view];
    toVC.view.alpha = 0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
       
        fromVC.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        toVC.view.alpha = 1;
        
    } completion:^(BOOL finished) {
       
        fromVC.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
}

@end
