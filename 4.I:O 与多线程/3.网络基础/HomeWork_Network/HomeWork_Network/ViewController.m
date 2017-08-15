//
//  ViewController.m
//  HomeWork_Network
//
//  Created by wd on 2017/7/23.
//  Copyright © 2017年 ditiy. All rights reserved.
//

#import "ViewController.h"
#import "POSTViewController.h"
#import "DownloadFileViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *cell1;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell2;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.navigationItem.title = @"网络 - 第三章作业";
    
    self.cell1.textLabel.text = @"POST请求";
    
    self.cell2.textLabel.text = @"下载文件";
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        POSTViewController *vc = [POSTViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        
        DownloadFileViewController *vc = [DownloadFileViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
