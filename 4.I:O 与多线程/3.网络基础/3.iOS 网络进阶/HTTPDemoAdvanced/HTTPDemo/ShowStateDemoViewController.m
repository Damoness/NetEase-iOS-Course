//
//  StateDemoViewController.m
//  HTTPDemo
//
//  Created by Netease on 16/8/26.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ShowStateDemoViewController.h"
#import "NECircleChart.h"

@interface ShowStateDemoViewController () <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, strong) UIButton *downloadBtn;
@property (nonatomic, strong) UIButton *downloadWithDataBtn;

@property (nonatomic, strong) NECircleChart *circleChart;

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) NSString *responseString;

@end

@implementation ShowStateDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self loadSubviews];
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

- (void)loadSubviews {
    self.downloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, 160, 44)];
    [self.downloadBtn setTitle:@"DownloadTask状态" forState:UIControlStateNormal];
    self.downloadBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.downloadBtn.backgroundColor = [UIColor orangeColor];
    [self.downloadBtn addTarget:self action:@selector(downloadFileWithProgress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.downloadBtn];
    
    self.downloadWithDataBtn = [[UIButton alloc] initWithFrame:CGRectMake(180, 80, 160, 44)];
    [self.downloadWithDataBtn setTitle:@"DataTask状态" forState:UIControlStateNormal];
    self.downloadWithDataBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.downloadWithDataBtn addTarget:self action:@selector(testDataTask) forControlEvents:UIControlEventTouchUpInside];
    self.downloadWithDataBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.downloadWithDataBtn];
    
    CGRect rect = CGRectMake(0, 150.0, CGRectGetWidth(self.view.frame), 200.0);
    self.circleChart = [[NECircleChart alloc] initWithFrame:rect
                                                      total:@100
                                                    current:@(0)
                                                  clockwise:YES];
    self.circleChart.backgroundColor = [UIColor clearColor];
    [self.circleChart setStrokeColor:[UIColor orangeColor]];
    [self.view addSubview:self.circleChart];
}

#pragma mark - Test

- (void)downloadFileWithProgress {
    self.circleChart.current = @(0);
    [self.circleChart setNeedsDisplay];
    
    NSURL *url = [NSURL URLWithString:@"https://codeload.github.com/AFNetworking/AFNetworking/zip/master"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    [task resume];
}

- (void)testDataTask {
    self.circleChart.current = @(0);
    [self.circleChart setNeedsDisplay];
    
    NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/book/17604305?fields=title,id,url,publisher,author"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    [task resume];
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    NSLog(@"Task %@ state is %@", task, @(task.state));
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    NSLog(@"Task %@ state is %@", dataTask, @(dataTask.state));
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    NSLog(@"Task %@ state is %@", dataTask, @(dataTask.state));
    
    self.response = response;
    self.responseData = [NSMutableData data];
    if (completionHandler) {
        completionHandler(NSURLSessionResponseAllow);
        NSLog(@"Task %@ state is %@", dataTask, @(dataTask.state));
    }
}

#pragma mark - NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"Task %@ state is %@", downloadTask, @(downloadTask.state));
    
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *destination = [documentsDirectoryURL URLByAppendingPathComponent:[downloadTask.response suggestedFilename]];
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:destination error:nil];
    
    self.circleChart.current = @(100);
    [self.circleChart setNeedsDisplay];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    NSLog(@"Task %@ state is %@", downloadTask, @(downloadTask.state));
    
    self.circleChart.current = @(totalBytesWritten * 100 / totalBytesExpectedToWrite);
    NSLog(@"下载进度: %@%%", self.circleChart.current);
    if (self.circleChart.current.integerValue > 1) {
        [self.circleChart setNeedsDisplay];
    }
}

@end
