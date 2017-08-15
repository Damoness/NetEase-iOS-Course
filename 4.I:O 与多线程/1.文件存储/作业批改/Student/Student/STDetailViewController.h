//
//  STDetailViewController.h
//  Student
//
//  Created by jele lam on 21/7/2017.
//  Copyright © 2017年 jele lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Students.h"
@interface STDetailViewController : UITableViewController
@property (nonatomic, strong) NSString *subject;
- (instancetype)initWithData:(NSArray *)data mode:(NSString *)string title:(NSString *)title;
@end
