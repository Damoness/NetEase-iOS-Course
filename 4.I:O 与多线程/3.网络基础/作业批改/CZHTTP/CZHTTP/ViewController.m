//
//  ViewController.m
//  CZHTTP
//
//  Created by zhen7216 on 2017/7/21.
//  Copyright © 2017年 chenzhen. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, CZDemoType) {
    CZDemoPostSession = 1,
    CZDemoDownload
};

static NSString * const kUICellIdentifier = @"UICellIdentifier";
NSString * const kPutsreqTestURL = @"http://httpbin.org/post";


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate, NSURLConnectionDataDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *dataList;

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) NSString *responseString;
@property (nonatomic, strong) id responseInfo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadTableView];
    [self loadData];
}

- (void)loadTableView {
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kUICellIdentifier];
    [self.view addSubview:self.tableView];
}

- (void)loadData {
    self.dataList = [NSMutableArray array];
    [self.dataList addObject:@{@"tag": @(CZDemoDownload), @"title": @"下载文件"}];
    [self.dataList addObject:@{@"tag": @(CZDemoPostSession), @"title": @"POST请求 NSURLSession"}];
}

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataList[indexPath.row] objectForKey:@"title"];
}

- (CZDemoType)viewTypeAtIndexPath:(NSIndexPath *)indexPath {
    return (CZDemoType)[[self.dataList[indexPath.row] objectForKey:@"tag"] integerValue];
}

#pragma mark - table view datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kUICellIdentifier];
    cell.textLabel.text = [self titleAtIndexPath:indexPath];
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    CZDemoType demoType = [self viewTypeAtIndexPath:indexPath];
    switch (demoType) {
            
        case CZDemoDownload:
            [self testDownload];
            break;
            
        case CZDemoPostSession:
            [self testPostRequestWithNSURLSession];
            break;
            
        default:
            break;
    }
}

#pragma mark - Demo

- (void)testDownload {
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/image/jpeg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.response = response;
        if (error.code == 0 && nil != data) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSURL *destination = [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
            NSString *str = destination.absoluteString;
            [data writeToURL:destination atomically:NO];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"下载成功" message:str preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
            NSLog(@"%@", str);
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"下载失败" message:@"请重新下载" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    [task resume];
}

- (void)testPostRequestWithNSURLSession {
    NSURL *url = [NSURL URLWithString:kPutsreqTestURL];
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    mutableRequest.HTTPMethod = @"POST";
    [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
//    NSDictionary *parameters = @{@"book": @(17603398), @"title": @"好书", @"comment": @"我觉得这是一本好书", @"rating": @(5)};
//    NSData *body = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
//    [mutableRequest setHTTPBody:body];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:mutableRequest];
    [task resume];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(nonnull NSURLResponse *)response {
    NSLog(@"%@", response);
    self.response = response;
    self.responseData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(nonnull NSData *)data {
    NSLog(@"%@", data);
    if (nil != data) {
        [self.responseData appendData:data];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Request %@ failed with error: %@", connection.currentRequest, error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Request %@ finished successfully", connection.currentRequest);
    NSStringEncoding stringEncoding = NSUTF8StringEncoding;
    self.responseString = [[NSString alloc] initWithData:self.responseData encoding:stringEncoding];
    self.responseInfo = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
    NSLog(@"返回数据： %@", self.responseString);
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    if (nil != data) {
        [self.responseData appendData:data];
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    self.response = response;
    self.responseData = [NSMutableData data];
    if (completionHandler) {
        completionHandler(NSURLSessionResponseAllow);
    }
}

#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
    if (error.code != 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"post出错" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    NSStringEncoding stringEncoding = NSUTF8StringEncoding;
    if (self.response.textEncodingName) {
        CFStringEncoding IANAEncoding = CFStringConvertIANACharSetNameToEncoding((__bridge CFStringRef)self.response.textEncodingName);
        if (IANAEncoding != kCFStringEncodingInvalidId) {
            stringEncoding = CFStringConvertEncodingToNSStringEncoding(IANAEncoding);
        }
    }
    
    self.responseString = [[NSString alloc] initWithData:self.responseData encoding:stringEncoding];
    NSLog(@"返回数据：%@", self.responseString);
    
    self.responseInfo = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
