//
//  STDetailViewController.m
//  Student
//
//  Created by jele lam on 19/7/2017.
//  Copyright © 2017年 jele lam. All rights reserved.
//

#import "STDetailViewController.h"
#import "STDetailViewController.h"

static NSString *studentReuseIdentifier = @"Students_reuse_identifier";


@interface STDetailViewController ()
@property (nonatomic,strong)    UIButton *button;
@property (nonatomic,copy)      NSMutableArray *students;
@property (nonatomic,copy)      NSMutableArray *filteredStudents;
@property (nonatomic,assign)    BOOL shouldShowButton;
@end

@implementation STDetailViewController

- (instancetype)initWithData:(NSArray *)dataSource mode:(NSString *)string title:(NSString *)title {
    if (self = [super init]) {
        self.title = title;
        _shouldShowButton = [string isEqualToString:@"subject"] ? YES : NO;
        [self setData:dataSource];
    }
    return self;
}

- (void)setData:(NSArray *)dataSource {
    _students = [NSMutableArray arrayWithArray:dataSource];
    _filteredStudents = [NSMutableArray array];
    [_students enumerateObjectsUsingBlock:^(Students * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.score.floatValue < 60) {
            [_filteredStudents addObject:obj];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.button.selected ? [self.filteredStudents count] : [self.students count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    Students *student = self.button.selected ? self.filteredStudents[index] : self.students[index];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:studentReuseIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:studentReuseIdentifier];
    }
    if (_shouldShowButton){
        cell.textLabel.text = student.studentName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"分数:%@", student.score.stringValue];
    } else {
        cell.textLabel.text = student.subjectName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"分数:%@", student.score.stringValue];
    }
    return cell;
}

#pragma mark - misc
- (void)setup
{
    if (_shouldShowButton) {
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50.f)];
        [self.button setTitle:@"显示科目分数不及格的学生" forState:UIControlStateNormal];
        [self.button setTitle:@"显示所有科目分数" forState:UIControlStateSelected];
        [self.button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.button setBackgroundColor:[UIColor whiteColor]];
        [self.button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.tableView.tableHeaderView = self.button;
        
        self.tableView.frame = CGRectMake(0, 114.f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width - 114.f);
    }
}

- (void)buttonClick {
    self.button.selected = !self.button.selected;
    [self.tableView reloadData];
}
- (void)updateData:(NSMutableArray *)array {
    [self setData:array];
    [self.tableView reloadData];
}
@end
