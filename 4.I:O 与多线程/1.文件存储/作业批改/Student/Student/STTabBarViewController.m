//
//  STTabBarViewController.m
//  Student
//
//  Created by jele lam on 19/7/2017.
//  Copyright © 2017年 jele lam. All rights reserved.
//

#import "STTabBarViewController.h"
#import "STSubjectTableViewController.h"
#import "STStudentNameViewController.h"
#import "AddStudentsViewController.h"
#import "FMDatabase.h"
#import "Students.h"

@interface STTabBarViewController ()<AddStudentsDelegate,STStudentNameViewControllerDelegate>
@property (nonatomic, strong) FMDatabase *database;
@property (nonatomic, strong) Students *student;
@property (nonatomic, strong) STStudentNameViewController *StudentNameViewController;
@property (nonatomic, strong) STSubjectTableViewController *sujectTableViewController;
@property (nonatomic, strong) NSMutableArray *students;
@end

@implementation STTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"mainView";
    _students = [NSMutableArray array];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
//                                                                             action:@selector(add:)];
                                                                             action:@selector(add:)];
    [self openDatabase];
    [self read];
    [self initSubViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)add:(id)sender
{
    AddStudentsViewController *vc = [[AddStudentsViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onCancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onAddStudents:(Students *)Students
{
    
    if ([_database executeUpdate:@"insert into Students (name,subject,score) values (?,?,?)",Students.studentName,Students.subjectName,Students.score])
    {
        [_students addObject:Students];
        [self.StudentNameViewController updateData:_students];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - store
- (void)openDatabase
{
    NSString *filepath = [self filepath];
    _database = [FMDatabase databaseWithPath:filepath];
    if ([_database open])
    {
        if (![_database executeUpdate:@"create table if not exists Students(id integer primary key autoincrement,name text,subject text,score NUMERIC)"])
        {
            NSLog(@"open database failed");
        }
    }
    else
    {
        NSLog(@"open database failed");
    }
}

- (void)dealloc
{
    [_database close];
}

- (void)read
{
    FMResultSet *set = [_database executeQuery:@"select * from Students"];
    while ([set next])
    {
        Students *student =[[Students alloc] init];
        student.serialId = [set longLongIntForColumn:@"id"];
        student.studentName = [set stringForColumn:@"name"];
        student.subjectName = [set stringForColumn:@"subject"];
        student.score = @([set doubleForColumn:@"score"]);
        [self.students addObject:student];
    }
    [set close];
    
//    [self.tableView reloadData];
}

- (void)initSubViewController {
    _StudentNameViewController = [[STStudentNameViewController alloc] initWithData:self.students];
    _StudentNameViewController.delegate = self;
    _sujectTableViewController = [[STSubjectTableViewController alloc] initWithData:self.students];
    _StudentNameViewController.title = @"学生";
    _sujectTableViewController.title = @"科目";
    self.viewControllers = @[
                             _StudentNameViewController,
                             _sujectTableViewController
                             ];

}
- (NSString *)filepath
{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return  [documents stringByAppendingPathComponent:@"Students.db"];
}

- (NSArray *)querySearchResult:(NSString *)queryString queryText:(NSString *)text {
    NSMutableArray *array = [NSMutableArray array];
    FMResultSet *set = [_database executeQuery:queryString,text];
    while ([set next])
    {
        
        Students *student =[[Students alloc] init];
        student.serialId = [set longLongIntForColumn:@"id"];
        student.studentName = [set stringForColumn:@"name"];
        student.subjectName = [set stringForColumn:@"subject"];
        student.score = @([set doubleForColumn:@"score"]);
        
        [array addObject:student];
    }
    [set close];
    return array;
}

- (BOOL)queryDeleteResult:(NSString *)queryString queryText:(NSString *)text step:(NSInteger)step {
    for (int i = 0; i < step; i++) {
        [_database executeUpdate:queryString,text];
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
