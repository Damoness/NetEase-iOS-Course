//
//  HomeTableViewController.m
//  HomeworkDemo
//
//  Created by Hmyy on 2017/7/23.
//  Copyright © 2017年 Hmyy. All rights reserved.
//

#import "HomeTableViewController.h"
#import "CourseTableViewController.h"
#import "StudentsTableViewController.h"
#import "ResultInputViewController.h"
#import "FMDatabase.h"

static NSString *homeCellReuseIdentifier = @"home_cell_reuse_identifier";

@interface HomeTableViewController ()<ResultInputDelegate>

@property (nonatomic, strong) NSArray<NSString *> *vcNames;

@property (nonatomic,strong) FMDatabase *database;

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setup];
    [self loadData];
    [self openDatabase];
    
}

- (void)dealloc
{
    [_database close];
}

#pragma mark - misc
- (void)setup
{
    self.title = @"录入成绩";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(add:)];
    
}

- (void)add:(id)sender
{
    ResultInputViewController *vc = [[ResultInputViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadData
{
    _vcNames = @[@"所有学生名字", @"所有科目"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ResultInputDelegate
- (void)onCancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onInputResult:(StudentResult *)result
{
    
    if ([_database executeUpdate:@"insert into results (name,course,score) values (?,?,?)",result.name,result.course,result.score])
        NSLog(@"插入成功");
    else
        NSLog(@"插入失败");
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - store
- (void)openDatabase
{
    NSString *filepath = [self filepath];
    _database = [FMDatabase databaseWithPath:filepath];
    if ([_database open])
    {
        if (![_database executeUpdate:@"create table if not exists results(id integer primary key autoincrement,name text,course text,score text)"])
        {
            NSLog(@"open database failed");
        }
    }
    else
    {
        NSLog(@"open database failed");
    }
}

- (NSString *)filepath
{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return  [documents stringByAppendingPathComponent:@"student_results.db"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    NSInteger index = indexPath.row;
    NSString *vcName = self.vcNames[index];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCellReuseIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:homeCellReuseIdentifier];
    }
    cell.textLabel.text = vcName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewController *vc = nil;
    switch (indexPath.row)
    {
        case 0:
            vc = [[StudentsTableViewController alloc] init];
            break;
        case 1:
            vc = [[CourseTableViewController alloc] init];
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
