//
//  GMGradeViewController.h
//  GradeMagament
//
//  Created by ShaoweiZhang on 8/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    DisplayGradeByName,
    DisplayGradeBySubject,
} DisplayGradeType;

@interface GMGradeViewController : UITableViewController

- (instancetype)initWithName:(NSString *)name;
- (instancetype)initWIthSubject:(NSString *)subject;

@end
