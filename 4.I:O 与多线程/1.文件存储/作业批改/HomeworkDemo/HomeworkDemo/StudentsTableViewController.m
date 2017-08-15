//
//  StudentsTableViewController.m
//  HomeworkDemo
//
//  Created by Hmyy on 2017/7/23.
//  Copyright © 2017年 Hmyy. All rights reserved.
//

#import "StudentsTableViewController.h"
#import "FMDatabase.h"
#import "StudentResult.h"
#import "CoursesAndGradesTableViewController.h"

static NSString *studentReuseIdentifier = @"student_reuse_identifier";
@interface StudentsTableViewController ()<UISearchBarDelegate,UISearchResultsUpdating>

@property (nonatomic,strong)    UISearchController *searchViewController;
@property (nonatomic,copy)      NSMutableArray *results;
@property (nonatomic,copy)      NSArray *filteredContacts;
@property (nonatomic,assign)    BOOL shouldShowSearchResult;
@property (nonatomic,strong)    FMDatabase *database;

@end

@implementation StudentsTableViewController

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
    self.title = @"所有学生名字";
    self.searchViewController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchViewController.searchBar.delegate = self;
    self.searchViewController.searchResultsUpdater = self;
    self.tableView.tableHeaderView = self.searchViewController.searchBar;
    
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
    FMResultSet *set = [_database executeQuery:@"select name from results"];
    while ([set next])
    {
        StudentResult *result = [[StudentResult alloc] init];
        result.name = [set stringForColumn:@"name"];
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
    return self.shouldShowSearchResult ? [self.filteredContacts count] : [self.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    NSInteger index = indexPath.row;
    
    StudentResult *result = self.shouldShowSearchResult ? self.filteredContacts[index] : self.results[index];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:studentReuseIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:studentReuseIdentifier];
    }
    cell.textLabel.text = result.name;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.shouldShowSearchResult == NO;   //搜索结果不做删除处理
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StudentResult *result = self.results[indexPath.row];
    CoursesAndGradesTableViewController *vc = [[CoursesAndGradesTableViewController alloc] init];
    vc.studentName = result.name;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - search
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.shouldShowSearchResult = YES;
    self.filteredContacts = nil;
    [self.tableView reloadData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    self.shouldShowSearchResult = NO;
    self.filteredContacts = nil;
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.shouldShowSearchResult = NO;
    self.filteredContacts = nil;
    [self.tableView reloadData];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *text = searchController.searchBar.text;
    NSMutableArray *contacts = nil;
    if ([text length])
    {
        NSString *searchText = [NSString stringWithFormat:@"%%%@%%",text];
        contacts = [NSMutableArray array];
        NSString *sql = @"select * from results where name like ?";
        
        FMResultSet *set = [_database executeQuery:sql,searchText,searchText];
        while ([set next])
        {
            StudentResult *result = [[StudentResult alloc] init];
            result.name = [set stringForColumn:@"name"];
            [self.results addObject:result];
        }
        [set close];
    }
    
    self.filteredContacts = contacts;
    [self.tableView reloadData];
}

@end
