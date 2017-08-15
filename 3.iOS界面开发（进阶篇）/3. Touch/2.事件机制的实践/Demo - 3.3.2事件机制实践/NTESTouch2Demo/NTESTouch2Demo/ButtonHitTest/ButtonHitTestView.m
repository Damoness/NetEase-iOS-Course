//
//  ButtonHitTestView.m
//  Touch2Demo
//
//  Created by jeunfung on 16/8/4.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ButtonHitTestView.h"

const static CGFloat buttonExtraPadding = 20;

@interface ButtonHitTestView()
{
    UIView *_buttonBgView;  //演示作用，实际不会存在
    UIButton *_button;
}
@end

@implementation ButtonHitTestView

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
        
        _button = [[UIButton alloc] init];
        [_button setBackgroundColor:[UIColor orangeColor]];
        [_button setTitle:@"button" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)buttonClicked:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"button clicked" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect targetRect = CGRectMake(CGRectGetMinX(_button.frame) - buttonExtraPadding, CGRectGetMinY(_button.frame) - buttonExtraPadding, CGRectGetWidth(_button.frame) + buttonExtraPadding * 2, CGRectGetHeight(_button.frame) + buttonExtraPadding * 2);
    
    targetRect = CGRectInset(_button.frame, - buttonExtraPadding, - buttonExtraPadding);
    
    if (CGRectContainsPoint(targetRect, point))
    {
        return _button;
    }
    
    return [super hitTest:point withEvent:event];
}

@end
