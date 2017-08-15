//
//  StudentViewController.m
//  HomeWork_File
//
//  Created by wd on 2017/7/23.
//  Copyright © 2017年 ditiy. All rights reserved.
//

#import "StudentViewController.h"
#import "AddRecordViewController.h"
#import "Record.h"
#import "FMDatabase.h"
#import "DatabaseManager.h"
#import "ShowScoreTableViewController.h"
static NSString *recordReuseIdentifier = @"recordReuseIdentifier";


@interface StudentViewController ()<AddRecordDelegate,UISearchBarDelegate,UISearchResultsUpdating>


@property (nonatomic,strong)    UISearchController *searchViewController;
@property (nonatomic) NSMutableArray<Record *>*records;
@property (nonatomic,copy)      NSArray *filteredRecords;
@property (nonatomic,assign)    BOOL shouldShowSearchResult;
@end

@implementation StudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self initViews];
    
    [self reloadData];
}


-(void)initViews{
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加记录" style:UIBarButtonItemStylePlain target:self action:@selector(add:)];
    
    
    self.navigationItem.title = @"学生记录";
    
    self.searchViewController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchViewController.searchBar.delegate = self;
    self.searchViewController.searchResultsUpdater = self;
    self.tableView.tableHeaderView = self.searchViewController.searchBar;
    
    
}

-(void)reloadData{
    
    self.records = [[DatabaseManager sharedManager]readAllNames];
    [self.tableView reloadData];
    
}


-(void)addRecord:(Record *)record{
    
    
    if ([[DatabaseManager sharedManager]addRecord:record]) {
        
        [self reloadData];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)add:(UIBarButtonItem *)item{
    
    
    AddRecordViewController *vc = [AddRecordViewController new];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.shouldShowSearchResult ? self.filteredRecords.count : self.records.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recordReuseIdentifier];

    
    Record *record = self.shouldShowSearchResult ? self.filteredRecords[indexPath.row] :self.records[indexPath.row];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recordReuseIdentifier];
    }
    
    cell.textLabel.text = record.name;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    Record *record = self.records[indexPath.row];
    
    ShowScoreTableViewController *vc = [ShowScoreTableViewController new];
    vc.navigationItem.title = [record.name stringByAppendingString:@" 的成绩"];
    vc.records = [[DatabaseManager sharedManager]readScoresOfName:record.name];
    
    [self.navigationController pushViewController:vc animated:YES];
    

    
}

#pragma mark - search
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.shouldShowSearchResult = YES;
    self.filteredRecords = nil;
    [self.tableView reloadData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    self.shouldShowSearchResult = NO;
    self.filteredRecords = nil;
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.shouldShowSearchResult = NO;
    self.filteredRecords = nil;
    [self.tableView reloadData];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *text = searchController.searchBar.text;

    if ([text length])
    {
        self.filteredRecords = [[DatabaseManager sharedManager]readAllNamesByStr:text];
    }
    
    [self.tableView reloadData];
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
