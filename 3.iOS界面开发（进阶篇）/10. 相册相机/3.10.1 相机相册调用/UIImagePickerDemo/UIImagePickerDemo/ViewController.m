//
//  ViewController.m
//  UIImagePickerDemo
//
//  Created by 吴狄 on 2017/8/11.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>


@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong,nonatomic) UIImagePickerController *picker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



//拍照
- (IBAction)takePhotoAction:(UIButton *)sender {
    
    //判断是否摄像头是否可用
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        
        UIImagePickerController *imagePickerController = [UIImagePickerController new];
        imagePickerController.delegate = self;
        
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        imagePickerController.mediaTypes = @[(__bridge_transfer NSString *)kUTTypeImage];
        
        imagePickerController.allowsEditing = YES;
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
        
    }
    
}


//拍照（定制界面）
- (IBAction)takePhotoAction2:(UIButton *)sender {
    
    //判断是否摄像头是否可用
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        
        UIImagePickerController *imagePickerController = [UIImagePickerController new];
        self.picker = imagePickerController;
        imagePickerController.delegate = self;
        
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        imagePickerController.mediaTypes = @[(__bridge_transfer NSString *)kUTTypeImage];
        
        UIButton *cameraOverlayButton = [[UIButton alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 100) /2, CGRectGetHeight(self.view.frame) - 100, 100, 50)];
        
        [cameraOverlayButton setTitle:@"拍照" forState:UIControlStateNormal];
        [cameraOverlayButton addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
        //cameraOverlayButton.backgroundColor = [UIColor whiteColor];
        
        
        imagePickerController.showsCameraControls = NO;
        imagePickerController.cameraOverlayView = cameraOverlayButton;
        imagePickerController.allowsEditing = YES;
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
        
    }
    
}


-(void)takePhoto{
    
    [self.picker takePicture];
    
    
}

//拍视频
- (IBAction)takeVideoAction:(UIButton *)sender {
    
    //判断是否摄像头是否可用
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        
        UIImagePickerController *imagePickerController = [UIImagePickerController new];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.allowsEditing = YES;
        imagePickerController.mediaTypes = @[(__bridge_transfer NSString *)kUTTypeMovie];
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
        
    }
    
    
    
}


//选择本地图片
- (IBAction)openPhotoAction:(UIButton *)sender {
    
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //时刻界面
    imagePickerController.allowsEditing = YES;
    imagePickerController.mediaTypes = @[(__bridge_transfer NSString *)kUTTypeImage];
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
}


//选择本地视频
- (IBAction)openVideoAction:(UIButton *)sender {
    
    
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片跟目录
 
    imagePickerController.mediaTypes = @[(__bridge_transfer NSString *)kUTTypeMovie];
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
    
}

#pragma mark -- delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    
    if (info[UIImagePickerControllerMediaType] == (__bridge_transfer NSString *)kUTTypeImage) {
        UIImage *editedImage = info[UIImagePickerControllerEditedImage];
        UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
        
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
            
            //保存图片到本地相册
            UIImageWriteToSavedPhotosAlbum(editedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
        
        
        self.imageView.image = editedImage;
        
    }else if (info[UIImagePickerControllerMediaType] == (__bridge_transfer NSString *)kUTTypeMovie){
        
        
        //处理视频数据
    }
    

    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;

#pragma mark -- 保存图片

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error) {
        NSLog(@"保存失败");
    }else{
        NSLog(@"保存成功");
    }
    
}

@end
