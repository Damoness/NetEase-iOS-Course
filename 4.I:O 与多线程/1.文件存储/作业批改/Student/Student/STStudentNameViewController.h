//
//  STStudentNameViewController.h
//  Student
//
//  Created by jele lam on 19/7/2017.
//  Copyright © 2017年 jele lam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STStudentNameViewControllerDelegate <NSObject>
- (NSArray *)querySearchResult:(NSString *)queryString queryText:(NSString *)text;
- (BOOL)queryDeleteResult:(NSString *)queryString queryText:(NSString *)text step:(NSInteger)step;
@end

@interface STStudentNameViewController : UITableViewController
- (instancetype)initWithData:(NSArray *)dataSource;
@property (nonatomic, weak) id<STStudentNameViewControllerDelegate> delegate;
- (void)updateData:(NSMutableArray *)array;
@end
