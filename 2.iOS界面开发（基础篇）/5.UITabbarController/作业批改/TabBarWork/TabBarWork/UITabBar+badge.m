//
//  UITabBar+badge.m
//  TabBarWork
//
//  Created by lusuihao-mac on 2017/5/16.
//  Copyright © 2017年 lusuihao-mac. All rights reserved.
//

#import "UITabBar+badge.h"

@implementation UITabBar (badge)

-(void)showBadgeAtIndex:(NSInteger)index{
    UIView *badgeView = [UIView new];
    badgeView.tag = index;
    badgeView.layer.cornerRadius = 5;
    badgeView.backgroundColor = [UIColor colorWithRed:223.0f/255.0f green:26.0f/255.0f blue:59.0f/255.0f alpha:1.0f];
    CGRect Frame = self.frame;
    
    CGFloat x = ceilf(Frame.size.width * (index + 0.65)/5);
    CGFloat y = ceilf(Frame.size.height * 0.1);
    badgeView.frame = CGRectMake(x, y, 10, 10);
    [self addSubview:badgeView];


}

@end
