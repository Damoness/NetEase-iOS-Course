//
//  TestView.m
//  Event_Me
//
//  Created by 吴狄 on 2017/7/7.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "TestView.h"

@implementation TestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    NSLog(@"touch Began %@",self.name);
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"touch Moved %@",self.name);
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"touch Ended %@",self.name);
    [super touchesEnded:touches withEvent:event];
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    
    
    NSLog(@"hit test from %@", self.name);
    

    
    UIView *hitView= [super hitTest:point withEvent:event];
    
    
    NSLog(@"return hit view %@, self %@", hitView, self);
    
    
    return hitView;
    
}


-(NSString *)description{
    
    
   return  [NSString stringWithFormat:@"[TestView %@]", self.name];
    
}

@end
