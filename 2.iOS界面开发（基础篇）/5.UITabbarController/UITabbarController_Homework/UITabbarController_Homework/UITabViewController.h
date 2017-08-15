//
//  UITabViewController.h
//  UITabbarController_Homework
//
//  Created by wd on 2017/5/30.
//  Copyright © 2017年 ditiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabViewController : UITabBarController


- (void)showBadgeOnItemIndex:(NSInteger)index;   ///<显示小红点

- (void)hideBadgeOnItemIndex:(NSInteger)index;  ///<隐藏小红点

@end
