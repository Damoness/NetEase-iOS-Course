//
//  AchivementsTableViewController.h
//  学生成绩录入系统
//
//  Created by zhen7216 on 2017/7/8.
//  Copyright © 2017年 chenzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AchivementsTableViewController : UITableViewController
@property (nonatomic, copy) NSArray *achivements;

- (instancetype)initWithAchivements:(NSArray *)achivements;
@end
