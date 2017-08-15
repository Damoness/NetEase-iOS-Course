//
//  SubTableViewController.m
//  学生成绩录入系统
//
//  Created by zhen7216 on 2017/7/9.
//  Copyright © 2017年 chenzhen. All rights reserved.
//

#import "SubTableViewController.h"

#import "StatisticSystem+CoreDataProperties.h"


static NSString *achivementReuseIdentifier = @"achivement_reuse_identifier";


@interface SubTableViewController ()

@end

@implementation SubTableViewController

- (instancetype)initWithAchivements:(NSArray *)achivements {
    self = [super init];
    if (self) {
        _achivements = achivements;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(363, 60, 46, 30)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    return [self.achivements count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StatisticSystem *statistic = self.achivements[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:achivementReuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:achivementReuseIdentifier];
    }
    cell.textLabel.text = statistic.name;
    cell.detailTextLabel.text = statistic.achivement;
    return cell;
}

@end
