//
//  GMStudentTableViewController.m
//  GradeMagament
//
//  Created by ShaoweiZhang on 8/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "GMStudentTableViewController.h"
#import "GMAddStudentViewController.h"
#import "GMGradeViewController.h"

@interface GMStudentTableViewController () <UISearchBarDelegate,UISearchResultsUpdating, AddStudentDelegate>
{
    UISearchController *_searchViewController;
    NSMutableArray<NSString*> *_nameArray;
    NSArray *_filteredNameArray;
    BOOL _shouldShowSearchResult;
}

@end

@implementation GMStudentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"学生";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    _searchViewController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchViewController.searchBar.delegate = self;
    _searchViewController.searchResultsUpdater = self;
    self.tableView.tableHeaderView = _searchViewController.searchBar;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addStudent)];
}

- (void)viewWillAppear:(BOOL)animated
{
    _nameArray = [NSMutableArray arrayWithArray:[[GMDataCenter sharedInstance] getAllNames]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addStudent
{
    GMAddStudentViewController *vc = [[GMAddStudentViewController alloc] init];
    vc.delegate = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _shouldShowSearchResult ? _filteredNameArray.count : _nameArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell"];
    NSString *name = _shouldShowSearchResult ? [_filteredNameArray objectAtIndex:indexPath.row] : [_nameArray objectAtIndex:indexPath.row];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NameCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMGradeViewController *vc = [[GMGradeViewController alloc] initWithName:[_nameArray objectAtIndex:indexPath.row]];
    vc.hidesBottomBarWhenPushed = YES;
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
#pragma add student record
- (void)onAddStudentRecord:(GMRecord *)record
{
    [[GMDataCenter sharedInstance] addRecord:record];
    BOOL nameAlreadyExists = NO;
    for (NSString *name in _nameArray) {
        if ([name isEqualToString:record.name]) {
            nameAlreadyExists = YES;
            break;
        }
    }
    
    if (!nameAlreadyExists) {
        [_nameArray addObject:record.name];
        [self.tableView reloadData];
    }
}

#pragma search controller
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _shouldShowSearchResult = YES;
    _filteredNameArray = nil;
    [self.tableView reloadData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    _shouldShowSearchResult = NO;
    _filteredNameArray = nil;
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _shouldShowSearchResult = NO;
    _filteredNameArray = nil;
    [self.tableView reloadData];
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *keywords = searchController.searchBar.text;
    if ([keywords length]) {
        _filteredNameArray = [[GMDataCenter sharedInstance] searchNameByKeywords:keywords];
    }
    
    [self.tableView reloadData];
}

@end
