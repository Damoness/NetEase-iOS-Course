//
//  ShowScoreTableViewController.m
//  HomeWork_File
//
//  Created by wd on 2017/7/23.
//  Copyright © 2017年 ditiy. All rights reserved.
//

#import "ShowScoreTableViewController.h"


static NSString *Score_Cell_identifier = @"Score_Cell_identifier";
@interface ShowScoreTableViewController ()


@end


@implementation ShowScoreTableViewController
@synthesize records = _records;

-(NSMutableArray *)records{
    
    if (!_records) {
        _records = [NSMutableArray array];
    }
    return _records;
    
}

-(void)setRecords:(NSMutableArray *)records{
    
    if (records) {
        _records = records;
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //self.navigationItem.title = @"成绩";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.records.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Score_Cell_identifier];
    
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Score_Cell_identifier];
    }
    
    cell.textLabel.text = self.records[indexPath.row].subject;
    cell.detailTextLabel.text = self.records[indexPath.row].score;
    
    return cell;
}


-(void)filter:(UIBarButtonItem *)item{
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    
    
    [self.records enumerateObjectsUsingBlock:^(Record * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj.score intValue] >= 60) {
            
            [indexSet addIndex:idx];
        
        }

    }];
    
    [self.records removeObjectsAtIndexes:indexSet];
    
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
