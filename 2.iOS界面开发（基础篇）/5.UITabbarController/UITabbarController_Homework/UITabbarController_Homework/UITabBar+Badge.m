//
//  UITabBar+Badge.m
//  UITabbarController_Homework
//
//  Created by wd on 2017/5/30.
//  Copyright © 2017年 ditiy. All rights reserved.
//

#import "UITabBar+Badge.h"

@implementation UITabBar (Badge)

#define TabbarItemNums  5.0


- (void)showBadgeOnItemIndex:(NSInteger)index{
    
    [self removeBadgeOnItemIndex:index];
    
    
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 5.0;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    
    CGFloat percentX = (index + 0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10.0, 10.0);
    badgeView.clipsToBounds = YES;
    [self addSubview:badgeView];
}

- (void)hideBadgeOnItemIndex:(NSInteger)index{
    
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(NSInteger)index{
    
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}





@end
