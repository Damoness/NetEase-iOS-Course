//
//  TestViewControllerB.h
//  NTESViewController1Demo
//
//  Created by jeunfung on 16/8/27.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString *const TestViewControllerBNotification;

typedef void(^DataBlock) (NSString * data);

@class TestViewControllerB;
@protocol TestViewControllerBDelegate <NSObject>

- (void)testViewControllerB:(TestViewControllerB *)testViewControllerB sendDataBack:(NSString *)data;

@end

@interface TestViewControllerB : UIViewController

- (instancetype)initWithProperty1:(NSString *)property1Value;

- (instancetype)initWithDataBlock:(DataBlock)dataBlock;

- (instancetype)initWithNotification;

- (instancetype)initWithMediator;

@property (nonatomic, retain) NSString *property1;

@property (nonatomic, weak) id<TestViewControllerBDelegate> delegate;

@end
