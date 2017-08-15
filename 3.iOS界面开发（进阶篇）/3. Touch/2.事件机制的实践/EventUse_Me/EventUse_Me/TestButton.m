//
//  TestButton.m
//  EventUse_Me
//
//  Created by 吴狄 on 2017/7/11.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "TestButton.h"
const static CGFloat buttonExtraPadding = 20;
@implementation TestButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    

    NSLog(@"point:%@",NSStringFromCGPoint(point));
    
    CGRect targetRect = CGRectInset(self.bounds,- buttonExtraPadding, -buttonExtraPadding);
    
    if (CGRectContainsPoint(targetRect, point)) {
        
        return YES;
    }
    
    
    return [super pointInside:point withEvent:event];
    
}

@end
