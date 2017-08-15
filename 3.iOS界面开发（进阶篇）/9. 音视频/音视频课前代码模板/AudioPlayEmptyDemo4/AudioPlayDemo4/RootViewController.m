//
//  RootViewController.m
//  AudioPlayDemo
//
//  Created by Chengyin on 16/7/31.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "RootViewController.h"

@interface AudioObject : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *className;
@end

@implementation AudioObject

@end

@implementation RootViewController
{
    NSArray *_data;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    AudioObject *record = [AudioObject new];
    record.title = @"Record Audio";
    record.className = @"RecordViewController";
    
    _data = @[record];
}

#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"defaultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [_data[indexPath.row] title];
    return cell;
}


#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *className = [_data[indexPath.row] className];
    UIViewController *viewController = [NSClassFromString(className) new];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
