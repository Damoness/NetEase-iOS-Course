//
//  CourseTableViewController.m
//  HomeworkDemo
//
//  Created by Hmyy on 2017/7/23.
//  Copyright © 2017年 Hmyy. All rights reserved.
//

#import "CourseTableViewController.h"
#import "FMDatabase.h"
#import "StudentResult.h"
#import "StudentsAndScoresTableViewController.h"

static NSString *courseReuseIdentifier = @"course_reuse_identifier";

@interface CourseTableViewController ()<UISearchBarDelegate,UISearchResultsUpdating>

@property (nonatomic,copy)      NSMutableArray *results;
@property (nonatomic,strong)    FMDatabase *database;

@end

@implementation CourseTableViewController

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
    self.title = @"所有科目";
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
    FMResultSet *set = [_database executeQuery:@"select course from results"];
    while ([set next])
    {
        StudentResult *result = [[StudentResult alloc] init];
        result.course = [set stringForColumn:@"course"];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    NSInteger index = indexPath.row;
    
    StudentResult *result = self.results[index];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:courseReuseIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:courseReuseIdentifier];
    }
    cell.textLabel.text = result.course;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StudentResult *result = self.results[indexPath.row];
    StudentsAndScoresTableViewController *vc = [[StudentsAndScoresTableViewController alloc] init];
    vc.course = result.course;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
