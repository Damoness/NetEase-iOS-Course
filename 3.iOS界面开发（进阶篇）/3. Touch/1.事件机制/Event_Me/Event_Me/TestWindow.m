//
//  TestWindow.m
//  Event_Me
//
//  Created by 吴狄 on 2017/7/7.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "TestWindow.h"

@implementation TestWindow

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)sendEvent:(UIEvent *)event{
    
    
    NSLog(@"Window send event");
    [super sendEvent:event];
    
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"Window touch Ended");
    [super touchesEnded:touches withEvent:event];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"Window touch began");
     [super touchesBegan:touches withEvent:event];
}

@end
