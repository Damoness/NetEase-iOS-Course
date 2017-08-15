//
//  CoursesAndGradesTableViewController.m
//  HomeworkDemo
//
//  Created by Hmyy on 2017/7/23.
//  Copyright © 2017年 Hmyy. All rights reserved.
//

#import "CoursesAndGradesTableViewController.h"
#import "FMDatabase.h"
#import "StudentResult.h"

static NSString *studentReuseIdentifier = @"student_reuse_identifier";
@interface CoursesAndGradesTableViewController ()

@property (nonatomic,copy)      NSMutableArray *results;
@property (nonatomic,strong)    FMDatabase *database;

@end

@implementation CoursesAndGradesTableViewController

- (instancetype)init
{
    if (self = [super init])
    {
        _results = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc
{
    [_database close];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self openDatabase];
    [self read];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - misc
- (void)setup
{
    self.title = @"该学生的科目和成绩";
}


#pragma mark - store
- (void)openDatabase
{
    NSString *filepath = [self filepath];
    _database = [FMDatabase databaseWithPath:filepath];
    if ([_database open])
    {
        NSLog(@"open database success");
    }
    else
    {
        NSLog(@"open database failed");
    }
}

- (void)read
{
    FMResultSet *set = [_database executeQuery:@"select * from results where name = ?", self.studentName];
    while ([set next])
    {
        StudentResult *result = [[StudentResult alloc] init];
        result.course = [set stringForColumn:@"course"];
        result.score = [set stringForColumn:@"score"];
        [self.results addObject:result];
    }
    [set close];
    [self.tableView reloadData];
}

- (NSString *)filepath
{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return  [documents stringByAppendingPathComponent:@"student_results.db"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    NSInteger index = indexPath.row;
    
    StudentResult *result = self.results[index];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:studentReuseIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:studentReuseIdentifier];
    }
    cell.textLabel.text = result.course;
    cell.detailTextLabel.text = result.score;
    
    return cell;
}

@end
