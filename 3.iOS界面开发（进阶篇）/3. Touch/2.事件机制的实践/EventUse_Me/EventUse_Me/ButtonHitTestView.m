//
//  ButtonHitTestView.m
//  EventUse_Me
//
//  Created by 吴狄 on 2017/7/11.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "ButtonHitTestView.h"

const static CGFloat buttonExtraPadding = 20;

@interface ButtonHitTestView()
{
    UIView *_buttonBgView;
    UIButton *_button;
}

@end

@implementation ButtonHitTestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    
    
    NSLog(@"%@",NSStringFromCGPoint(point));
   
    
    CGRect targetRect = CGRectMake(CGRectGetMinX(_button.frame) - buttonExtraPadding, CGRectGetMinY(_button.frame) - buttonExtraPadding, CGRectGetWidth(_button.frame) + 2 * buttonExtraPadding, CGRectGetHeight(_button.frame) + 2 * buttonExtraPadding);
    
    targetRect = CGRectInset(_button.frame, -buttonExtraPadding, -buttonExtraPadding);
    
    if (CGRectContainsPoint(targetRect, point)) {
        
        return _button;
    }
    
    return [super hitTest:point withEvent:event];
    
}


-(instancetype)init{

    
    self = [self initWithFrame:CGRectZero];
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setUp];
        
    }
    return  self;
    
}


-(void)setUp{
    
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    _buttonBgView = [UIView new];
    _buttonBgView.layer.borderColor = UIColor.redColor.CGColor;
    _buttonBgView.layer.borderWidth = 1;
    [self addSubview:_buttonBgView];
    
    _button = [[UIButton alloc]init];
    
    [_button setTitle:@"按钮" forState:UIControlStateNormal];
    [_button setTitleColor:UIColor.blueColor forState:UIControlStateHighlighted];
    _button.layer.cornerRadius = 6;
    _button.layer.borderWidth = 2;
    _button.layer.borderColor = UIColor.redColor.CGColor;
    _button.layer.masksToBounds = YES;
    
    [self addSubview:_button];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    _button.frame = CGRectMake(50, 50, 100, 30);
    _buttonBgView.frame = CGRectInset(_button.frame, -buttonExtraPadding, -buttonExtraPadding);
    
}

@end
