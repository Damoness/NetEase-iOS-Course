//
//  STTabBarViewController.h
//  Student
//
//  Created by jele lam on 19/7/2017.
//  Copyright © 2017年 jele lam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STTabBarViewControllerDelegate <NSObject>

- (NSArray *)queryResult:(NSString *)qureyString;

@end

@interface STTabBarViewController : UITabBarController
@property (nonatomic, weak) id<STTabBarViewControllerDelegate> delegare;
@end
