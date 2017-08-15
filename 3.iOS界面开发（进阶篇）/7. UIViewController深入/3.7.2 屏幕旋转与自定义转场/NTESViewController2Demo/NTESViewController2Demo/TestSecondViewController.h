//
//  TestSecondViewController.h
//  NTESViewController2Demo
//
//  Created by jeunfung on 16/11/2.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestSecondViewController;
@protocol TestSecondViewControllerDelegate <NSObject>

- (void)testSecondViewControllerDismiss:(TestSecondViewController *)viewController;

@end

@interface TestSecondViewController : UIViewController

@property (nonatomic, weak) id<TestSecondViewControllerDelegate> delegate;

- (instancetype)initWithFromPush:(BOOL)fromPush;

@end
