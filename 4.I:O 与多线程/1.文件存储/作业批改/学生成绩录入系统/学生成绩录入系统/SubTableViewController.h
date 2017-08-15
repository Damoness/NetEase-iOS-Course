//
//  SubTableViewController.h
//  学生成绩录入系统
//
//  Created by zhen7216 on 2017/7/9.
//  Copyright © 2017年 chenzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubTableViewController : UITableViewController
@property (nonatomic, copy) NSArray *achivements;

- (instancetype)initWithAchivements:(NSArray *)achivements;
@end
