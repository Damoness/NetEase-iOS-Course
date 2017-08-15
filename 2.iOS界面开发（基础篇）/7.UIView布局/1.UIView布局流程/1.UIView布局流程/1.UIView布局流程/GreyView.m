//
//  GreyView.m
//  1.UIView布局流程
//
//  Created by 吴狄 on 2017/6/3.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "GreyView.h"
 
@implementation GreyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)updateConstraints{
    
    [super updateConstraints];
    
    NSLog(@"%s",__func__);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSLog(@"%s",__func__);
}

@end
