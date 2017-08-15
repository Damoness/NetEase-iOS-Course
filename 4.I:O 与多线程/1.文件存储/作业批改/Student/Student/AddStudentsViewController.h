//
//  AddStudentsViewController.h
//  StudentsDemo
//
//  Created by amao on 16/7/18.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Students.h"

@protocol AddStudentsDelegate <NSObject>
- (void)onAddStudents:(Students *)student;
- (void)onCancel;
@end

@interface AddStudentsViewController : UIViewController
@property (nonatomic,weak)  id<AddStudentsDelegate>  delegate;
@end
