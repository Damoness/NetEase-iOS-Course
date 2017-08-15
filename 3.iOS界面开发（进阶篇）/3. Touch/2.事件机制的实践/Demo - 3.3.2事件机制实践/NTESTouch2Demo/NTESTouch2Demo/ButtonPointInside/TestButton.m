//
//  TestButton.m
//  NTESTouch2Demo
//
//  Created by jeunfung on 16/8/5.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "TestButton.h"

@implementation TestButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGFloat buttonExtraPadding = 20;
    
    //way1
//    CGRect targetRect = CGRectInset(self.bounds, - buttonExtraPadding, - buttonExtraPadding);
//    if (CGRectContainsPoint(targetRect, point))
//    {
//        return YES;
//    }
    
    //way2
    CGPoint convertPoint = [self convertPoint:point toView:self.superview];
    CGRect targetRect = CGRectInset(self.frame, - buttonExtraPadding, - buttonExtraPadding);
    if (CGRectContainsPoint(targetRect, convertPoint))
    {
        return YES;
    }
    

    return [super pointInside:point withEvent:event];
    
}

@end
