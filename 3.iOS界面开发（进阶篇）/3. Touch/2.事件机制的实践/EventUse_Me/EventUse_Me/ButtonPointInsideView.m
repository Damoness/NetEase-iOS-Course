//
//  ButtonPointInsideView.m
//  EventUse_Me
//
//  Created by 吴狄 on 2017/7/11.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "ButtonPointInsideView.h"
#import "TestButton.h"
const static CGFloat buttonExtraPadding = 20;

@interface ButtonPointInsideView()
{
    UIView *_buttonBgView;  //演示作用，实际不会存在
    TestButton *_button;
}

@end
@implementation ButtonPointInsideView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor lightGrayColor];
        
        _buttonBgView = [[UIView alloc] init];
        _buttonBgView.layer.borderColor = [UIColor redColor].CGColor;
        _buttonBgView.layer.borderWidth = 1;
        [self addSubview:_buttonBgView];
        
        _button = [[TestButton alloc] init];
        [_button setBackgroundColor:[UIColor orangeColor]];
        [_button setTitle:@"button" forState:UIControlStateNormal];
        [_button setTitleColor:UIColor.redColor forState:UIControlStateHighlighted];
        //[_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _button.frame = CGRectMake(50, 50, 100, 30);
    
    _buttonBgView.frame = CGRectMake(_button.frame.origin.x - buttonExtraPadding, _button.frame.origin.y - buttonExtraPadding, _button.frame.size.width + buttonExtraPadding*2, _button.frame.size.height + buttonExtraPadding*2);
}



@end
