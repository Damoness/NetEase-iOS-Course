//
//  SecondViewController.m
//  学生成绩录入系统
//
//  Created by zhen7216 on 2017/7/7.
//  Copyright © 2017年 chenzhen. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"
#import "StatisticSystem+CoreDataProperties.h"

static NSString *studentReuseIdentifier = @"student_reuse_identifier";


@interface SecondViewController ()
@property (nonatomic, strong) UISearchController *searchViewController;
@property (nonatomic, copy) NSMutableArray *students;
@property (nonatomic, copy) NSArray *filteredStudents;
@property (nonatomic, assign) BOOL shouldShowSearchResult;
@end

@implementation SecondViewController

- (instancetype)init {
    if (self = [super init]) {
        _students = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    cell.textLabel.text = statisticSystem.subject;
    
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
    NSString *subject = statisticSystem.subject;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"subject = %@", subject];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"StatisticSystem"];
    [request setPredicate:predicate];
    
    NSArray *array = [context executeFetchRequest:request
                                            error:nil];
    SubTableViewController *achivementTc = [[SubTableViewController alloc] initWithAchivements:array];
    [self presentViewController:achivementTc animated:YES completion:nil];
}


@end
