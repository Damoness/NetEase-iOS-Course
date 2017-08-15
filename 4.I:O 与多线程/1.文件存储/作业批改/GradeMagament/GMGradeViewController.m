//
//  GMGradeViewController.m
//  GradeMagament
//
//  Created by ShaoweiZhang on 8/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "GMGradeViewController.h"
#import "GMDataCenter.h"

@interface GMGradeViewController ()
{
    NSMutableArray *_gradeArray;
    NSMutableArray *_failedGradeArray;
    DisplayGradeType _type;
    NSString *_name;
    NSString *_subject;
    BOOL _onlyShowFailedGrade;
}
@end

@implementation GMGradeViewController

- (instancetype)initWithName:(NSString *)name
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _type = DisplayGradeByName;
        _name = name;
        _onlyShowFailedGrade = NO;
    }
    
    return self;
}

- (instancetype)initWIthSubject:(NSString *)subject
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _type = DisplayGradeBySubject;
        _subject = subject;
        _onlyShowFailedGrade = NO;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _failedGradeArray = [NSMutableArray array];
    
    if (_type == DisplayGradeByName) {
        _gradeArray = [NSMutableArray arrayWithArray:[[GMDataCenter sharedInstance] getRecordsForName:_name]];
        self.title = _name;
    }
    else {
        _gradeArray = [NSMutableArray arrayWithArray:[[GMDataCenter sharedInstance] getRecordsForSubject:_subject]];
        self.title = _subject;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"显示不及格" style:UIBarButtonItemStylePlain target:self action:@selector(filter)];
    }
    
    for (GMRecord *record in _gradeArray) {
        if (record.grade < 60.00) {
            [_failedGradeArray addObject:record];
        }
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)filter
{
    _onlyShowFailedGrade = !_onlyShowFailedGrade;
    if (_onlyShowFailedGrade) {
        self.navigationItem.rightBarButtonItem.title = @"显示全部";
    }
    else {
        self.navigationItem.rightBarButtonItem.title = @"显示不及格";
    }
    
    [self.tableView reloadData];
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
    if (_onlyShowFailedGrade && _type == DisplayGradeBySubject) {
        return _failedGradeArray.count;
    }
    
    return _gradeArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GMRecord *record = nil;
    if (_onlyShowFailedGrade && _type == DisplayGradeBySubject) {
        record = [_failedGradeArray objectAtIndex:indexPath.row];
    }
    else {
        record = [_gradeArray objectAtIndex:indexPath.row];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GradeCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"GradeCell"];
    }
    
    if (_type == DisplayGradeByName) {
        cell.textLabel.text = record.subject;
    }
    else {
        cell.textLabel.text = record.name;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", record.grade];
    return cell;
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
