//
//  FolderViewController.m
//  FinderForiOS_Me
//
//  Created by 吴狄 on 2017/7/12.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "FolderViewController.h"


/*
 1.遍历目录
 2.创建目录
 3.删除目录
 4.写入文件
 5.删除文件
 6.读取文件
 
 */


static NSString *folder_Cell_Identifier = @"folder_Cell_Identifier";

@interface FolderViewController ()
@property (nonatomic) NSString *dir;
@property (nonatomic) NSMutableArray *items;
@end

@implementation FolderViewController


-(instancetype)initWithDir:(NSString *)dir{
    
    
    self = [super init];
    if (self) {
     
        _dir = dir;
        
    }
    
    return self;
    
}



#pragma mark --  1.遍历目录
-(void)refresh{
    

    self.items =  [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.dir error:nil].mutableCopy;
    
    [self.tableView reloadData];
    
}


#pragma mark --  2.创建目录
-(void)add{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择要创建的类型" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *createFileAction = [UIAlertAction actionWithTitle:@"创建文件" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSString *newFilePath = [self pathByName:@"创建的文件"];
        
        
        
        NSString *str = [NSDate  date].description;
        
        
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        [data writeToFile:newFilePath atomically:YES];
        
        [self refresh];
        
        
        
    }];
    
    
    UIAlertAction *createDirAction = [UIAlertAction actionWithTitle:@"创建目录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
        NSString *newDirPath = [self pathByName:@"创建目录"];
        
        
        [[NSFileManager defaultManager] createDirectoryAtPath:newDirPath withIntermediateDirectories:YES attributes:nil error:nil];
        
        
        [self refresh];
        
        
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:cancelAction];
    
    

    [alertController addAction:createDirAction];
    [alertController addAction:createFileAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    

}


#pragma mark --  3.删除目录
-(void)delete:(NSString *)name{
    
    
    NSFileManager *manager =  [NSFileManager defaultManager];
    
    NSString *path = [self.dir stringByAppendingPathComponent:name];
    
    [manager removeItemAtPath:path error:nil];
    
}



-(NSString *)pathByName:(NSString *)name{
    
    
    NSString *basePath = [self.dir stringByAppendingPathComponent:name];
    NSString *path = basePath;
    NSInteger index = 0;
    
    
    while([[NSFileManager defaultManager] fileExistsAtPath:path]){
        
        index++;
        
        path = [NSString stringWithFormat:@"%@-%zd",basePath,index];
        
    }
    
    return path;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:folder_Cell_Identifier];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"增加" style:UIBarButtonItemStylePlain target:self action:@selector(add)];
    
    [self refresh];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return ;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    

    return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:folder_Cell_Identifier forIndexPath:indexPath];
    
    
    cell.textLabel.text = self.items[indexPath.row];
    
    return cell;
}





// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        
        [self delete:self.items[indexPath.row]];
        
    
        //[self refresh];
        
        [self.items removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *path = [self.dir stringByAppendingPathComponent:self.items[indexPath.row]];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    
    if ([manager fileExistsAtPath:path isDirectory:&isDir]) {
        
        if (isDir) {
        
            
            FolderViewController *folderVC = [[FolderViewController alloc]initWithDir:path];
            
            [self.navigationController pushViewController:folderVC animated:YES];
            
            
        }else{
            
            
            //NSData *data = [NSData dataWithContentsOfFile:path];
            
            NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            
            NSLog(@"str:%@",str);
            
            
        }
        
    }
    
    
}



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
