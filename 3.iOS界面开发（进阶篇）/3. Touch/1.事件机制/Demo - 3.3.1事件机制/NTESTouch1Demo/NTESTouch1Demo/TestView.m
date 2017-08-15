//
//  TestView.m
//  NTESTouch1Demo
//
//  Created by jeunfung on 16/7/26.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch began %@", self.name);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch moved %@", self.name);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch ended %@", self);
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
//    NSLog(@"hit test from %@", self.name);
    
    UIView *hitView = [super hitTest:point withEvent:event];
    
//    NSLog(@"return hit view %@, self %@", hitView, self);
    
    return hitView;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"[TestView %@]", self.name];
}

@end
