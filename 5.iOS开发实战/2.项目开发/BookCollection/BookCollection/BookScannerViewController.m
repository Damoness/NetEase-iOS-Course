//
//  BookScannerViewController.m
//  BookCollection
//
//  Created by 吴狄 on 2017/7/27.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "BookScannerViewController.h"
#import "AVFoundation/AVFoundation.h"
#import "AFNetworking.h"
#import "ScanView.h"
#import "BookCollection-Swift.h"
@interface BookScannerViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic,strong) ScanView *scanView;

@property (nonatomic,strong) AVCaptureSession *session;

@end

@implementation BookScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self initNavigation];
    
    [self initSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)initSubViews{
    
    
    [self initCamera];
    [self initScanView];
    
    
}

-(void)initCamera{
    self.session = [[AVCaptureSession alloc]init];
    
    [self.session beginConfiguration];
    
    //输入
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    
    NSError *error = nil;
    
    AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (error == nil) {
        
        if ([self.session canAddInput:captureInput]) {
            [self.session addInput:captureInput];
        }
        
        
    }
    
    //输出
    AVCaptureMetadataOutput *captureOutput = [[AVCaptureMetadataOutput alloc]init];
    
    [captureOutput  setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    if ([self.session canAddOutput:captureOutput]) {
        [self.session addOutput:captureOutput];
        captureOutput.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code];
    }
    
    
    //添加预览层
    
    CALayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    layer.frame = self.view.layer.bounds;
    
    [self.view.layer addSublayer:layer];
    
    
    
    [self.session commitConfiguration];
    
    
    [self.session startRunning];
}


-(void)initTips{
    
    
    
}


-(void)initNavigation{
    
    //生产全透明导航栏
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back-button"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    

    //开启关闭手电筒
    UIButton *flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [flashButton setImage:[UIImage imageNamed:@"light-off"] forState:UIControlStateNormal];
    [flashButton setImage:[UIImage imageNamed:@"light-on"] forState:UIControlStateSelected];
    [flashButton sizeToFit];
    
    [flashButton addTarget:self action:@selector(flashButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:flashButton];
    
    
    
}



-(void)initScanView{
    
    self.scanView = [[ScanView alloc]initWithFrame:self.view.bounds rectSize:CGSizeMake(230, 230) offsetY:-43];
    [self.view addSubview:self.scanView];
    
    
    [self.scanView startAnimation];

}


-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)flashButtonPressed:(UIButton *)button{
    
    button.selected = !button.selected;
    
    
    
}

#pragma mark -- ISBN识别

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    NSString *ISBN = nil;
    
    for (AVMetadataObject *metadata in metadataObjects) {
        
        ISBN = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
        
        break;
    }
    
    
    if (ISBN !=nil) {
        
        
        NSLog(@"ISBN:%@",ISBN);
        
        [self.session stopRunning];
        [self.scanView stopAnimation];
        
        [self fetchBookWithISBN:ISBN];
    }
    
    
}


-(void)fetchBookWithISBN:(NSString *)ISBN{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/book/isbn/%@",ISBN]];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
       
        
        if (error !=nil) {
            
            NSLog(@"Error:%@",error);
            
        }else{
            
            NSLog(@"response %@,responseObject %@",response,responseObject);
            
            
            NSString *title = responseObject[@"title"];
            NSString *author = [responseObject[@"author"]firstObject];
            
            
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@\n%@\n%@",title,ISBN,author] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *detailAction = [UIAlertAction actionWithTitle:@"查看详情" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            UIAlertAction *nextAction = [UIAlertAction actionWithTitle:@"收藏并继续扫描" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self.session startRunning];
                [self.scanView startAnimation];
                
            }];
            
            [alertVC addAction:detailAction];
            [alertVC addAction:nextAction];
            
            
            [self presentViewController:alertVC animated:YES completion:nil];
        }
        
        
        
    }];
    
    
    [dataTask resume];
    
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
