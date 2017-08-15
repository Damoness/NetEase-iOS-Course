//
//  MyCameraViewController.m
//  AVCaptureSessionDemo
//
//  Created by Chengyin on 16/9/22.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "MyCameraViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MyCameraViewController ()
{
@private
    AVCaptureSession *_session;
    AVCaptureDeviceInput *_deviceInput;
    AVCaptureStillImageOutput *_imageOutput;
    AVCaptureVideoPreviewLayer *_previewLayer;
    
    AVCaptureFlashMode _flashMode;
}
@property (nonatomic,assign) AVCaptureFlashMode flashMode;
@end

@implementation MyCameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Take" style:UIBarButtonItemStylePlain target:self action:@selector(takeAction:)];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    
    UIButton *switchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    switchButton.frame = CGRectMake(0, 0, titleView.bounds.size.width / 2, titleView.bounds.size.height);
    switchButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [switchButton setTitle:@"Switch" forState:UIControlStateNormal];
    [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:switchButton];
    
    UIButton *flashButton = [UIButton buttonWithType:UIButtonTypeSystem];
    flashButton.frame = CGRectMake(titleView.bounds.size.width / 2, 0, titleView.bounds.size.width / 2, titleView.bounds.size.height);
    flashButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [flashButton setTitle:@"Flash" forState:UIControlStateNormal];
    [flashButton addTarget:self action:@selector(flashAction:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:flashButton];
    
    self.navigationItem.titleView = titleView;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.title = @"Camera";
    
    _flashMode = AVCaptureFlashModeAuto;
    [self requestAuthorization:^(BOOL granted) {
        [self performSelectorOnMainThread:@selector(requestAuthorizationFinished:) withObject:@(granted) waitUntilDone:NO];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self startCamera];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self stopCamera];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - permission
- (void)requestAuthorization:(void(^)(BOOL granted))handler
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusNotDetermined)
    {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:handler];
    }
    else if (handler)
    {
        handler(status == AVAuthorizationStatusAuthorized);
    }
}

- (void)requestAuthorizationFinished:(NSNumber *)granted
{
    if ([granted boolValue])
    {
        [self startCamera];
    }
    else
    {
        // handle error
    }
}

#pragma mark - actions
- (void)cancelAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)takeAction:(id)sender
{
    [self takePhoto:^(UIImage *image) {
        [self performSelectorOnMainThread:@selector(takePhotoFinished:) withObject:image waitUntilDone:NO];
    }];
}

- (void)takePhotoFinished:(UIImage *)image
{
    //    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    if ([_delegate respondsToSelector:@selector(cameraViewController:imageCaptured:)])
    {
        [_delegate cameraViewController:self imageCaptured:image];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)switchAction:(id)sender
{
    [self switchCamera];
}


- (void)flashAction:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Flash Mode" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    void(^alertAction)(UIAlertAction *) = ^(UIAlertAction *action){
        if ([action.title isEqualToString:@"Off"])
        {
            self.flashMode = AVCaptureFlashModeOff;
        }
        else if ([action.title isEqualToString:@"On"])
        {
            self.flashMode = AVCaptureFlashModeOn;
        }
        else if ([action.title isEqualToString:@"Auto"])
        {
            self.flashMode = AVCaptureFlashModeAuto;
        }
    };
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Off" style:UIAlertActionStyleDefault handler:alertAction];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"On" style:UIAlertActionStyleDefault handler:alertAction];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"Auto" style:UIAlertActionStyleDefault handler:alertAction];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    
    __weak typeof(alertController)weakAlertController = alertController;
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakAlertController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - device
- (AVCaptureDevice *)defaultCamera
{
    return [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if (device.position == position)
        {
            return device;
        }
    }
    return nil;
}

- (AVCaptureDevice *)frontCamera
{
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

- (AVCaptureDevice *)backCamera
{
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

- (AVCaptureDeviceInput *)deviceInputWithDevice:(AVCaptureDevice *)device
{
    [self setFlashModeForDevice:device];
    NSError *error = nil;
    AVCaptureDeviceInput *deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    if (!deviceInput)
    {
        NSLog(@"%@",error);
    }
    return deviceInput;
}

- (AVCaptureDeviceInput *)nextDeviceInput
{
    AVCaptureDevicePosition nextPosition = AVCaptureDevicePositionUnspecified;
    if (_deviceInput.device.position == AVCaptureDevicePositionBack)
    {
        nextPosition = AVCaptureDevicePositionFront;
    }
    else if (_deviceInput.device.position == AVCaptureDevicePositionFront)
    {
        nextPosition = AVCaptureDevicePositionBack;
    }
    
    if (nextPosition != AVCaptureDevicePositionUnspecified)
    {
        return [self deviceInputWithDevice:[self cameraWithPosition:nextPosition]];
    }
    return nil;
}

#pragma mark - flashMode
- (void)setFlashMode:(AVCaptureFlashMode)flashMode
{
    if (_flashMode == flashMode)
    {
        return;
    }
    
    _flashMode = flashMode;
    [self setFlashModeForDevice:_deviceInput.device];
}

- (void)setFlashModeForDevice:(AVCaptureDevice *)device
{
    if (device.flashMode != _flashMode && [device isFlashModeSupported:_flashMode])
    {
        NSError *error = nil;
        [device lockForConfiguration:&error];
        if (!error)
        {
            device.flashMode = _flashMode;
        }
        else
        {
            _flashMode = device.flashMode;
        }
        [device unlockForConfiguration];
    }
    else
    {
        _flashMode = device.flashMode;
    }
}

#pragma mark - camera
- (BOOL)createCamera
{
    if (_session)
    {
        return YES;
    }
    
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    if (![session canSetSessionPreset:AVCaptureSessionPresetPhoto])
    {
        return NO;
    }
    session.sessionPreset = AVCaptureSessionPresetPhoto;
    
    _deviceInput = [self deviceInputWithDevice:[self defaultCamera]];
    if (!_deviceInput)
    {
        return NO;
    }
    
    if (![session canAddInput:_deviceInput])
    {
        return NO;
    }
    [session addInput:_deviceInput];
    
    _imageOutput = [[AVCaptureStillImageOutput alloc] init];
    _imageOutput.outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    
    if (![session canAddOutput:_imageOutput])
    {
        return NO;
    }
    [session addOutput:_imageOutput];
    
    _session = session;
    return YES;
}

- (BOOL)startCamera
{
    if (![self createCamera])
    {
        return NO;
    }
    
    if (_session && ![_session isRunning])
    {
        [_session startRunning];
    }
    
    [self createLayer];
    
    return YES;
}

- (void)stopCamera
{
    if ([_session isRunning])
    {
        [_session stopRunning];
    }
}

- (BOOL)switchCamera
{
    AVCaptureDeviceInput *nextDeviceInput = [self nextDeviceInput];
    if (nextDeviceInput)
    {
        BOOL success = NO;
        [_session beginConfiguration];
        [_session removeInput:_deviceInput];
        if ([_session canAddInput:nextDeviceInput])
        {
            [_session addInput:nextDeviceInput];
            _deviceInput = nextDeviceInput;
            success = YES;
        }
        else
        {
            [_session addInput:_deviceInput];
        }
        [_session commitConfiguration];
        return success;
    }
    return NO;
}

- (void)takePhoto:(void(^)(UIImage *image))finished
{
    if (!finished)
    {
        return;
    }
    
    AVCaptureConnection *videoConnection =  [_imageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection)
    {
        finished(nil);
        return;
    }
    
    [_imageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL)
        {
            finished(nil);
            return ;
        }
        NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *image = [UIImage imageWithData:data];
        finished(image);
    }];
}

#pragma mark - preview
- (void)createLayer
{
    if (_previewLayer)
    {
        return;
    }
    
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    _previewLayer.frame = self.view.layer.bounds;
    [self.view.layer addSublayer:_previewLayer];
}
@end
