//
//  TestApplication.m
//  NTESTouch1Demo
//
//  Created by jeunfung on 16/7/27.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "TestApplication.h"

@implementation TestApplication

- (void)sendEvent:(UIEvent *)event
{
    NSLog(@"application send event");
    [super sendEvent:event];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"application touch began");
    [super touchesBegan:touches withEvent:event];
}


@end
