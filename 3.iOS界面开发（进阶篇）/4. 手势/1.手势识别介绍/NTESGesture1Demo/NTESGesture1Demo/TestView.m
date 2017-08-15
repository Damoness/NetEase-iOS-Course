//
//  TestView.m
//  NTESGesture1Demo
//
//  Created by jeunfung on 16/8/14.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"TestView touch began");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"TestView touch ended");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"TestView touch cancelled");
}

@end
