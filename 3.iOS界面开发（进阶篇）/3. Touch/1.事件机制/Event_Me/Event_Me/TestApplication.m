//
//  TestApplication.m
//  Event_Me
//
//  Created by 吴狄 on 2017/7/7.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "TestApplication.h"

@implementation TestApplication

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"Application touch began");
    [super touchesBegan:touches withEvent:event];
    
    
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"Application touch Ended");
    [super touchesEnded:touches withEvent:event];
}

-(void)sendEvent:(UIEvent *)event{
    
    NSLog(@"Application send event");
     [super sendEvent:event];
}

@end
