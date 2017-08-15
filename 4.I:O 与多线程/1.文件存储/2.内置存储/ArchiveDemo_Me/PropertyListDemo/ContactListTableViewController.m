//
//  ContactListTableViewController.m
//  PropertyListDemo
//
//  Created by amao on 16/7/13.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ContactListTableViewController.h"
#import "AddContactViewController.h"


static NSString *contactReuseIdentifier = @"contact_reuse_identifier";


@interface ContactListTableViewController ()<AddContactDelegate>
@property (nonatomic,strong)    NSMutableArray<Contact *> *contacts;
@end

@implementation ContactListTableViewController

- (instancetype)init
{
    if (self = [super init])
    {
        _contacts = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    Contact *contact = self.contacts[index];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contactReuseIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:contactReuseIdentifier];
    }
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.mobile;
    return cell;
}

#pragma mark - misc
- (void)setup
{
    self.title = @"联系人列表";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(add:)];
    
    
    [self read];
}

- (void)add:(id)sender
{
    AddContactViewController *vc = [[AddContactViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)read{
    
    id object = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
    
    if ([object isKindOfClass:[NSArray class]]) {
        
        self.contacts = [NSMutableArray arrayWithArray:object];
    }
}

-(void)save{
    
    
    [self.contacts writeToFile:[self filePath] atomically:YES];
    
   [NSKeyedArchiver archiveRootObject:self.contacts toFile:[self filePath]];
    
    
    
}

-(NSString *)filePath{
    
    
    NSString *tmp = NSTemporaryDirectory();
    

    return [tmp stringByAppendingPathComponent:@"contact.archive"];
}

#pragma mark - AddContactDelegate
- (void)onCancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onAddContact:(Contact *)contact{
    [self.contacts addObject:contact];
    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
    
    [self save];
}
@end
