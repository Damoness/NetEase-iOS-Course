//
//  AddStudentViewController.h
//  学生成绩录入系统
//
//  Created by zhen7216 on 2017/7/7.
//  Copyright © 2017年 chenzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatisticSystem+CoreDataProperties.h"

@protocol AddStudentDelegate <NSObject>
- (void)onAddStudent:(NSString *)name
             subject:(NSString *)subject
          achivement:(NSString *)achivement;
- (void)onCancel;
@end

@interface AddStudentViewController : UIViewController
@property (nonatomic,weak)  id<AddStudentDelegate>  delegate;
@end
