//
//  ButtonSubViewOutsideView.m
//  Touch2Demo
//
//  Created by jeunfung on 16/8/4.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ButtonSubViewOutsideView.h"

const static CGFloat buttonExtraPadding = 20;

@interface ButtonSubViewOutsideView()
{
    UIButton *_button;

}

@end

@implementation ButtonSubViewOutsideView
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor lightGrayColor];
        
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
    
    _button.frame = CGRectMake(50, - buttonExtraPadding, 100, 30);
}

- (void)buttonClicked:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"button clicked" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([_button pointInside:[self convertPoint:point toView:_button] withEvent:event])
    {
        return YES;
    }
    
    return [super pointInside:point withEvent:event];
}

@end
