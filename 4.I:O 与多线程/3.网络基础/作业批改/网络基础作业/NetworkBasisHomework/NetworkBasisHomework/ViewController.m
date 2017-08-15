//
//  ViewController.m
//  NetworkBasisHomework
//
//  Created by Hmyy on 2017/7/23.
//  Copyright © 2017年 Hmyy. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, NJDemoType) {
    NJDemoPostSessionType = 1,
    NJDemoDownloadSessionType,
};
static NSString *const kUICellIdentifier = @"UICellIdentifier";
static NSString *const kPostTestURL = @"http://httpbin.org/post";
static NSString *const kDownloadURL = @"http://httpbin.org/image/jpeg";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property (nonatomic, strong) NSMutableArray<NSDictionary *> *dataList;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setup];
    [self loadData];
}

- (void)setup
{
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kUICellIdentifier];
    [self.view addSubview:_tableView];
}

- (void)loadData
{
    self.dataList = [NSMutableArray array];
    [self.dataList addObject:@{@"tag": @(NJDemoPostSessionType), @"title":@"NSURLSession POST"}];
    [self.dataList addObject:@{@"tag": @(NJDemoDownloadSessionType), @"title":@"NSURLSession download"}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataList[indexPath.row] objectForKey:@"title"];
}

- (NJDemoType)viewTypeAtIndexPath:(NSIndexPath *)indexPath
{
    return (NJDemoType)[[self.dataList[indexPath.row] objectForKey:@"tag"] integerValue];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NJDemoType demoType = [self viewTypeAtIndexPath:indexPath];
    switch (demoType)
    {
        case NJDemoPostSessionType:
            [self testPostRequestWithNSURLSession];
            break;
        case NJDemoDownloadSessionType:
            [self testDownloadRequestWithNSURLSession];
            break;
            
        default:
            break;
    }
}

#pragma mark - Demo

- (void)testPostRequestWithNSURLSession
{
    NSURL *url = [NSURL URLWithString:kPostTestURL];
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    mutableRequest.HTTPMethod = @"POST";
    [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary *parameters = @{@"title":@"post测试", @"comment":@"心情不好不坏"};
    NSData *body = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    [mutableRequest setHTTPBody:body];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:mutableRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showMessage:@"post请求出错!"];
            });
        }
        else
        {
            NSStringEncoding stringEncoding = NSUTF8StringEncoding;
            if (response.textEncodingName)
            {
                CFStringEncoding IANAEncoding = CFStringConvertIANACharSetNameToEncoding((__bridge CFStringRef)response.textEncodingName);
                if (IANAEncoding != kCFStringEncodingInvalidId)
                {
                    stringEncoding = CFStringConvertEncodingToNSStringEncoding(IANAEncoding);
                }
            }
            
            if (nil != data)
            {
                NSString *responseInfo = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"post请求，返回json: %@", responseInfo);
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showMessage:@"post请求，返回数据为空!"];
                });
            }
        }
    }];
    [task resume];
}

- (void)testDownloadRequestWithNSURLSession
{
    NSURL *url = [NSURL URLWithString:kDownloadURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                             [NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error.code == 0) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSURL *destination = [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
            [[NSFileManager defaultManager] moveItemAtURL:location toURL:destination error:nil];
            NSLog(@"下载文件的路径:%@", destination.absoluteString);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showMessage:destination.absoluteString];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showMessage:@"下载失败!"];            });
        }
    }];
    [task resume];
}

- (void)showMessage:(NSString *)message
{
    UIAlertController *alertController  = [UIAlertController alertControllerWithTitle:@"提示信息:" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:alertAction];
    
    if ( nil == self.presentedViewController )
    {
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

@end
