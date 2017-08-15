//
//  POSTViewController.m
//  HomeWork_Network
//
//  Created by wd on 2017/7/23.
//  Copyright © 2017年 ditiy. All rights reserved.
//

#import "POSTViewController.h"

@interface POSTViewController ()


@property (nonatomic) NSURLSession *session;

@end

@implementation POSTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = NSStringFromClass([self class]);
    
    
    
    self.session  =  [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/post"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary *parameters = @{@"title":@"POST请求", @"date":@"POST请求数据"};
    NSData *body = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    [request setHTTPBody:body];
    
    NSURLSessionTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
     
  
        if (data) {
            //NSLog(@"%@", response);
            NSString *resultStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"resultStr:%@",resultStr);
            
        }else if (error){
            
            NSString *errorInfo = error.localizedDescription;
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:errorInfo preferredStyle:UIAlertControllerStyleAlert];
            
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
