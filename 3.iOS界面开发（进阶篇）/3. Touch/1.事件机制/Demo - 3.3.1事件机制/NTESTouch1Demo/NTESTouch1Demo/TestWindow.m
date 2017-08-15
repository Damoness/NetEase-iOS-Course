//
//  TestWindow.m
//  NTESTouch1Demo
//
//  Created by jeunfung on 16/7/27.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "TestWindow.h"

@implementation TestWindow

- (void)sendEvent:(UIEvent *)event
{
    NSLog(@"window send event");
    [super sendEvent:event];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"window touch began");
    [super touchesBegan:touches withEvent:event];
}



@end
