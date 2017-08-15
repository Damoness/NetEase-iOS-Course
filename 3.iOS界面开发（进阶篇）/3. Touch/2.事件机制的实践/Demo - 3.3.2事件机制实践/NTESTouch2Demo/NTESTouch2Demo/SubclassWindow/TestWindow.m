//
//  TestWindow.m
//  NTESTouch2Demo
//
//  Created by jeunfung on 16/8/5.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "TestWindow.h"

@implementation TestWindow

- (void)sendEvent:(UIEvent *)event
{
//    BOOL needEnd = YES;
//    for (UITouch *touch in event.allTouches)
//    {
//        if ([touch.view isFirstResponder]) {
//            needEnd = NO;
//            break;
//        }
//    }
//    
//    if (needEnd)
//    {
//        [self endEditing:YES];
//    }
    
    
    [super sendEvent:event];
}

@end
