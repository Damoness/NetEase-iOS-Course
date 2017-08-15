//
//  STSubjectTableViewController.m
//  Student
//
//  Created by jele lam on 19/7/2017.
//  Copyright © 2017年 jele lam. All rights reserved.
//

#import "STSubjectTableViewController.h"
#import "STDetailViewController.h"

static NSString *studentReuseIdentifier = @"Students_reuse_identifier";


@interface STSubjectTableViewController ()
@property (nonatomic,strong)    UIButton *button;
@property (nonatomic,copy)      NSMutableArray *students;
@property (nonatomic,strong)    NSArray *subjects;
@property (nonatomic,copy)      NSArray *filteredStudents;
@property (nonatomic,assign)    BOOL shouldShowSearchResult;
@end

@implementation STSubjectTableViewController

- (instancetype)initWithData:(NSArray *)dataSource {
    if (self = [super init]) {
        [self setData:dataSource];
    }
    return self;
}

- (void)setData:(NSArray *)dataSource {
    _students = [NSMutableArray arrayWithArray:dataSource];
    [self setSubjects];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    //    [self openDatabase];
    //    [self read];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shouldShowSearchResult ? [self.filteredStudents count] : [self.subjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:studentReuseIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:studentReuseIdentifier];
    }
    cell.textLabel.text = _subjects[index];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *subject = _subjects[indexPath.row];
    __block NSMutableArray *array = [NSMutableArray array];
    [_students enumerateObjectsUsingBlock:^(Students * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([subject isEqualToString:obj.subjectName]) {
            [array addObject:obj];
        }
    }];
    [self.navigationController pushViewController:[[STDetailViewController alloc] initWithData:array mode:@"subject" title:subject]animated:YES];
}
#pragma mark - misc
- (void)setup
{
    [self setSubjects];
}

- (void)setSubjects{
    NSMutableArray *array = [NSMutableArray array];
    [_students enumerateObjectsUsingBlock:^(Students *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:obj.subjectName];
    }];
    NSSet *set = [NSSet setWithArray:array];
    _subjects = set.allObjects;
}


@end
