//
//  DownloadFileViewController.m
//  HomeWork_Network
//
//  Created by wd on 2017/7/23.
//  Copyright © 2017年 ditiy. All rights reserved.
//

#import "DownloadFileViewController.h"

@interface DownloadFileViewController ()
@property (nonatomic) NSURLSession *session;
@end

@implementation DownloadFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = NSStringFromClass([self class]);
    
    
    
    
    self.session  =  [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/image/jpeg"];
    
    
    NSURLSessionDownloadTask *task =   [self.session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        
        if (error.code == 0) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSURL *destination = [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
            [[NSFileManager defaultManager] moveItemAtURL:location toURL:destination error:nil];
            
            
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"地址" message:destination.absoluteString preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }else{
            
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:@"下载失败" preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }
        
        
        
    }];
    
    [task resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
