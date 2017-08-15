//
//  ViewController.m
//  第三章单元作业
//
//  Created by miaodong on 2017/7/17.
//  Copyright © 2017年 ctitc. All rights reserved.
//

/**
 *  1.利用NSURLSession发送POST请求到服务器，并且将服务器返回的结果打印出来, 如果请求出错，请弹出提示告知请求出错.
 
 *  2. 利用NSURLSession下载文件, 如果下载成功，请弹出提示告知下载文件的路径；否则，请弹出提示告知下载失败.
 
 */
#import "ViewController.h"

typedef NS_ENUM(NSInteger , requestType) {
    requestTypeSession = 1,//
    requestTypeDownload
};

static NSString *const kUICellIdentifier = @"kUICellIdentifier";    //cell复用标识符
static NSString *const kPostURL = @"http://httpbin.org/post";   //POST请求地址
static NSString *const kDownloadURL = @"http://httpbin.org/image/jpeg"; //图片下载地址(小狐狸)


@interface ViewController ()<UITableViewDelegate , UITableViewDataSource , NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

//tableview:
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *dataSource;

//获取网络数据:
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, copy) NSString *responseString;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) id responseInfo;//JSON数据
@property (nonatomic, strong) NSURLSessionConfiguration *configuration;
@property (nonatomic, strong) NSURLSession *session;


@end

@implementation ViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"第三章单元作业";
    
    [self loadTableView];
    [self loadData];
    

}

#pragma mark - 载入表视图
- (void)loadTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kUICellIdentifier];
    [self.view addSubview:self.tableView];
}


#pragma mark - 载入数据
- (void)loadData
{
    self.dataSource = [NSMutableArray array];
    //1.
    [self.dataSource addObject:@{
                                 @"tag" : @(requestTypeSession) ,
                                 @"title" : @"利用NSURLSession发送POST请求到服务器"
                                 }];
    //2.
    [self.dataSource addObject:@{
                                 @"tag" : @(requestTypeDownload) ,
                                 @"title" : @"利用NSURLSession下载文件"
                                 }];
    
}


#pragma mark - 自定义方法
- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource[indexPath.row] objectForKey:@"title"];
}

- (requestType)viewTypeAtIndexPath:(NSIndexPath *)indexPath
{
    return (requestType)[[self.dataSource[indexPath.row] objectForKey:@"tag"] integerValue];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kUICellIdentifier];
    cell.textLabel.text = [self titleAtIndexPath:indexPath];
    
    return cell;
}


#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    requestType type = [self viewTypeAtIndexPath:indexPath];
    switch (type) {
            
            //利用NSURLSession发送POST请求到服务器
        case requestTypeSession:
            [self testRequestTypeSession];
            break;
            
            //利用NSURLSession下载文件
        case requestTypeDownload:
            [self testRequestTypeDownload];
            break;
            
        default:
            break;
            
    }
}


#pragma mark - 利用NSURLSession发送POST请求到服务器
- (void)testRequestTypeSession
{
    NSURL *url = [NSURL URLWithString:kPostURL];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    mutableRequest.HTTPMethod = @"POST";
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:mutableRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (error.code == 0)
        {
            self.response = response;
            self.responseData = [NSMutableData dataWithData:data];
            self.responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
            self.responseInfo = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
            
            /**
             *  打印服务器返回的结果:
             */
            NSLog(@"%@" , self.response);
            NSLog(@"%@" , self.responseData);
            NSLog(@"%@" , self.responseString);
            NSLog(@"%@" , self.responseInfo);
            
        }
        else
        {
            NSLog(@"错误信息为: error = %@" , error);
            [self alertMessage:@"出错了宝贝儿~" AndTitle:@"AlertVC"];
        }
    }];
    [task resume];
}

#pragma mark - 利用NSURLSession下载文件
- (void)testRequestTypeDownload
{
    NSURL *url = [NSURL URLWithString:kDownloadURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (error.code == 0 && location != nil)//如果不出错 , 且下载数据所暂存的位置不为空则:
        {
            NSURL *documentDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSURL *destination = [documentDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
            [[NSFileManager defaultManager] moveItemAtURL:location toURL:destination error:nil];
            
            //拿到最终地址的字符串类型:
            NSString *path = [destination absoluteString];
            /**
             *  弹出提示框告知文件下载路径:
             */
            [self alertMessage:path AndTitle:nil];
        }
        else
        {
            NSLog(@"错误信息为: error = %@" , error);
            
            /**
             *  弹出提示框告知错误:
             */
            [self alertMessage:@"出错了宝贝~" AndTitle:nil];
        }
    }];
    
    [task resume];
}


#pragma mark - 弹窗提示方法
- (void)alertMessage:(NSString *)message AndTitle:(NSString *)title {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style: UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}



#pragma mark - 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end


