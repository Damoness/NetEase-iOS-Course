//
//  FirstViewController.m
//  学生成绩录入系统
//
//  Created by zhen7216 on 2017/7/7.
//  Copyright © 2017年 chenzhen. All rights reserved.
//

#import "FirstViewController.h"
#import "AddStudentViewController.h"
#import "AppDelegate.h"
#import "AchivementsTableViewController.h"


static NSString *studentReuseIdentifier = @"student_reuse_identifier";


@interface FirstViewController ()<AddStudentDelegate, UISearchBarDelegate, UISearchResultsUpdating>
@property (nonatomic, strong) UISearchController *searchViewController;
@property (nonatomic, copy) NSMutableArray *students;
@property (nonatomic, copy) NSArray *filteredStudents;
@property (nonatomic, assign) BOOL shouldShowSearchResult;
@end

@implementation FirstViewController

- (instancetype)init {
    if (self = [super init]) {
        _students = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self read];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - store

- (void)read {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"StatisticSystem"];
    NSManagedObjectContext *context = app.managedObjectContext;
    
    NSArray *students = [context executeFetchRequest:request error:nil];
    
    if (students) {
        [self.students addObjectsFromArray:students];
    }
}

#pragma mark - misc
- (void)setup {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(363, 60, 46, 30)];
    [button setTitle:@"添加" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    self.searchViewController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchViewController.searchBar.delegate = self;
    self.searchViewController.searchResultsUpdater = self;
    self.tableView.tableHeaderView = self.searchViewController.searchBar;
}

- (void)add:(id)sender {
    AddStudentViewController *vc = [[AddStudentViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void) onAddStudent:(NSString *)name subject:(NSString *)subject achivement:(NSString *)achivement {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = app.managedObjectContext;
    
    StatisticSystem *statisSystem = [NSEntityDescription insertNewObjectForEntityForName:@"StatisticSystem" inManagedObjectContext:context];
    statisSystem.name = name;
    statisSystem.subject = subject;
    statisSystem.achivement = achivement;
    [app saveContext];
    [self.students addObject:statisSystem];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) onCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    StatisticSystem *statisticSystem = self.shouldShowSearchResult ? self.filteredStudents[index] : self.students[index];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:studentReuseIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:studentReuseIdentifier];
    }
    
    cell.textLabel.text = statisticSystem.name;
    
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
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = app.managedObjectContext;
        StatisticSystem *statisticSystem = self.students[index];
        [self.students removeObjectAtIndex:index];
        [context deleteObject:statisticSystem];
        [app saveContext];
        
        [self.tableView reloadData];
        
    }
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [app managedObjectContext];
    StatisticSystem *statisticSystem = self.students[indexPath.row];
    NSString *name = statisticSystem.name;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"StatisticSystem"];
    [request setPredicate:predicate];
    
    NSArray *array = [context executeFetchRequest:request
                                       error:nil];
    AchivementsTableViewController *achivementTc = [[AchivementsTableViewController alloc] initWithAchivements:array];
    [self presentViewController:achivementTc animated:YES completion:nil];
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
    if ([text length])
    {
        NSString *searchText = [NSString stringWithFormat:@"*%@*",text];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = [app managedObjectContext];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K like %@",@"name",searchText];
        
        
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"StatisticSystem"];
        [request setPredicate:predicate];
        
        self.filteredStudents = [context executeFetchRequest:request
                                                       error:nil];
        NSLog(@"%@", self.filteredStudents);
    }
    else
    {
        self.filteredStudents = nil;
    }
    [self.tableView reloadData];
}

@end
