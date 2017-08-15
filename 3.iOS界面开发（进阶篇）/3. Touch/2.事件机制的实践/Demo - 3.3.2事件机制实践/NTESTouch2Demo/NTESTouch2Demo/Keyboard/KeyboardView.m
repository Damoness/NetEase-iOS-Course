//
//  KeyboardView.m
//  Touch2Demo
//
//  Created by jeunfung on 16/8/4.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "KeyboardView.h"

@interface KeyboardView()
{
    UITextField *_textField;
}

@end


@implementation KeyboardView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setBackgroundColor:[UIColor lightGrayColor]];
        
        _textField = [[UITextField alloc] init];
        [_textField setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_textField];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _textField.frame = CGRectMake(20, 50, 150, 30);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //way1
//    [_textField resignFirstResponder];
    
    //way2
//    [self endEditing:YES];
    
    //way3
//    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    //way4
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

@end
