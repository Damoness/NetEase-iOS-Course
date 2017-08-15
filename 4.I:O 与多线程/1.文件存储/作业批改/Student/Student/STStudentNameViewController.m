//
//  STStudentNameViewController.m
//  Student
//
//  Created by jele lam on 19/7/2017.
//  Copyright © 2017年 jele lam. All rights reserved.
//

#import "STStudentNameViewController.h"
#import "STDetailViewController.h"

static NSString *studentReuseIdentifier = @"Students_reuse_identifier";


@interface STStudentNameViewController ()<UISearchBarDelegate,UISearchResultsUpdating>
@property (nonatomic,strong)    UISearchController *searchViewController;
@property (nonatomic,copy)      NSMutableArray *students;
@property (nonatomic, strong)   NSMutableArray *studentsAll;
@property (nonatomic,copy)      NSArray *filteredStudents;
@property (nonatomic,assign)    BOOL shouldShowSearchResult;
@end

@implementation STStudentNameViewController


- (instancetype)init
{
    if (self = [super init])
    {
        _students = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithData:(NSArray *)dataSource {
    if (self = [super init]) {
        [self setData:dataSource];
    }
    return self;
}

- (void)setData:(NSArray *)dataSource {
    __block NSMutableArray *array = [NSMutableArray array];
    [dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Students *student = obj;
        [array addObject:student.studentName];
    }];
    NSSet *set = [NSSet setWithArray:array];
    _students = [NSMutableArray arrayWithArray:set.allObjects];
    _studentsAll = [NSMutableArray arrayWithArray:dataSource];
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
    return self.shouldShowSearchResult ? [self.filteredStudents count] : [self.students count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    Students *student = [[Students alloc] init];
    student.studentName = self.shouldShowSearchResult ? self.filteredStudents[index] : self.students[index];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:studentReuseIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:studentReuseIdentifier];
    }
    cell.textLabel.text = student.studentName;
//    cell.detailTextLabel.text = student.mobile;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.shouldShowSearchResult == NO;   //搜索结果不做删除处理
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSInteger index = [indexPath row];
        NSString *name = _students[index];
        __block NSInteger step = 0;
        [_studentsAll enumerateObjectsUsingBlock:^(Students * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.studentName isEqualToString:name]) {
                step+=1;
            }
        }];
        
        if ([self deleteSql:@"delete from Students where name = ?" text:self.students[index] step:step])
        {
            [self.students removeObjectAtIndex:index];
            [self.tableView reloadData];
        }
    }
}
- (BOOL)deleteSql:(NSString *)sql text:(NSString *)text step:(NSInteger)step {

    if (self.delegate && [self.delegate respondsToSelector:@selector(queryDeleteResult:queryText:step:)]) {
        return [self.delegate queryDeleteResult:sql queryText:text step:step];
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSString *name = _students[row];
    NSLog(@"%@",name);
    __block NSMutableArray *array = [NSMutableArray array];
    [_studentsAll enumerateObjectsUsingBlock:^(Students * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.studentName isEqualToString:name]) {
            [array addObject:obj];
        }
    }];
    if (array.count != 0) {
        [self.navigationController pushViewController:[[STDetailViewController alloc] initWithData:array mode:@"name" title:name]animated:YES];
    }
}
#pragma mark - misc
- (void)setup
{
    self.searchViewController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchViewController.searchBar.delegate = self;
    self.searchViewController.searchResultsUpdater = self;
    self.tableView.tableHeaderView = self.searchViewController.searchBar;
    
}

#pragma mark - search
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.shouldShowSearchResult = YES;
    self.filteredStudents = nil;
    [self.tableView reloadData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    self.shouldShowSearchResult = NO;
    self.filteredStudents = nil;
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.shouldShowSearchResult = NO;
    self.filteredStudents = nil;
    [self.tableView reloadData];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *text = searchController.searchBar.text;
    NSArray *students = nil;
    if ([text length])
    {
        NSString *searchText = [NSString stringWithFormat:@"%%%@%%",text];
        students = [NSMutableArray array];
        NSString *sql = @"select * from Students where name like ? ";
        students = [self result:sql text:searchText];
    }
    __block NSMutableArray *array = [NSMutableArray array];
    [students enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Students *student = obj;
        [array addObject:student.studentName];
    }];
    NSSet *set = [NSSet setWithArray:array];
    self.filteredStudents = set.allObjects;
    [self.tableView reloadData];
}


- (NSArray *)result:(NSString *)sql text:(NSString *)text {
    if (_delegate && [_delegate respondsToSelector:@selector(querySearchResult:queryText:)]) {
        NSArray *array = [_delegate querySearchResult:sql queryText:text];
        return array;
    }
    return nil;
}

- (void)updateData:(NSMutableArray *)array {
    [self setData:array];
    [self.tableView reloadData];
}
@end
