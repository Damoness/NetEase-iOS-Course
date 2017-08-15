//
//  PresentAnimation.m
//  NTESViewController2Demo
//
//  Created by jeunfung on 16/11/2.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "PresentAnimation.h"

@implementation PresentAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    
    CGRect targetFrame = [transitionContext finalFrameForViewController:toVC];
    toView.frame = CGRectOffset(targetFrame, 0, - targetFrame.size.height);
    
    //another try
//    targetFrame = CGRectOffset(targetFrame, 0, 200);
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        toView.frame = targetFrame;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
        
    }];
}

@end
