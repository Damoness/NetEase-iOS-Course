//
//  ColorView.m
//  1.UIView布局流程
//
//  Created by 吴狄 on 2017/6/3.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "ColorView.h"

@implementation ColorView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

     self = [super initWithCoder:aDecoder];
    
    
    if (self) {
        
        NSLog(@"%s",__func__);
        
    }
    
    return self;
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    NSLog(@"%s",__func__);
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    
    [self.whiteView addGestureRecognizer:gesture];
    
}

-(void)tapAction{
    
    self.whiteViewHeightConstraint.constant = self.whiteViewHeightConstraint.constant == 28 ? 40: 28;
    
}

-(void)updateConstraints{
    
    [super updateConstraints];
    
    NSLog(@"%s",__func__);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSLog(@"%s",__func__);
}
@end
