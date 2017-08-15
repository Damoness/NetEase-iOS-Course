//
//  ViewController.m
//  POST&DownloadTask
//
//  Created by lusuihao-mac on 2017/7/22.
//  Copyright © 2017年 lusuihao-mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDelegate,NSURLSessionDataDelegate,NSURLSessionTaskDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)POSTAction:(id)sender {
    NSURL * url = [NSURL URLWithString:@"http://httpbin.org/post"];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary * dict = @{@"project":@"NetEase Study",@"name":@"student 1",@"time":@"2017-07-22 19:40:28"};
    request.HTTPMethod = @"POST";
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"POST 请求错误" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"POST 请求成功，详情请看控制台" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            NSString * dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary * dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"JSON : %@",dataDictionary);
            NSLog(@"dataString : %@",dataString);
        
        }
    }];
    [task resume];
    
    
}
- (IBAction)POSTError:(id)sender {
    NSURL * url = [NSURL URLWithString:@"http://http.org/post"];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary * dict = @{@"project":@"NetEase Study",@"name":@"student 1",@"time":@"2017-07-22 19:40:28"};
    request.HTTPMethod = @"POST";
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"POST 请求错误" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"POST 请求成功，详情请看控制台" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            NSString * dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary * dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"JSON : %@",dataDictionary);
            NSLog(@"dataString : %@",dataString);
        }
    }];
    [task resume];
}
- (IBAction)DownloadAction:(id)sender {
    NSURL * url = [NSURL URLWithString:@"http://httpbin.org/image/jpeg"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDownloadTask * task = [session downloadTaskWithRequest:request];
    [task resume];
}
- (IBAction)DownloadError:(id)sender {
    NSURL * url = [NSURL URLWithString:@""];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDownloadTask * task = [session downloadTaskWithRequest:request];
    [task resume];
}
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if (error) {
        NSLog(@"error");
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"下载失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        NSLog(@"finished");
    
    }

}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    NSURL * path = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL * filePath = [path URLByAppendingPathComponent:[downloadTask.response suggestedFilename]];
    NSLog(@"%@",filePath);
    [[NSFileManager defaultManager]moveItemAtURL:location toURL:filePath error:nil];
    
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"下载成功\r\n 下载至:%@",filePath] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    


}



- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    int64_t progress = totalBytesWritten * 100 / totalBytesExpectedToWrite;
    NSLog(@"下载进度：%lld %%",progress);



}


@end
