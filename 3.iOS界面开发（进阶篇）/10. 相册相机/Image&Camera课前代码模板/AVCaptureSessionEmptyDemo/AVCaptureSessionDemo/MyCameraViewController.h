//
//  MyCameraViewController.h
//  AVCaptureSessionDemo
//
//  Created by Chengyin on 16/9/22.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyCameraViewController;
@protocol MyCameraViewControllerDelegate <NSObject>
@optional
- (void)cameraViewController:(MyCameraViewController *)cameraViewController imageCaptured:(UIImage *)image;
@end

@interface MyCameraViewController : UIViewController

@property (nonatomic,weak) id<MyCameraViewControllerDelegate> delegate;

@end
