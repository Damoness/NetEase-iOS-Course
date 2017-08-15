//
//  CustomContainerViewController.h
//  MVC
//
//  Created by wtndcs on 16/6/26.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomContainerViewController : UIViewController

// 容器视图
@property (nonatomic, weak) IBOutlet UIView *containerView; //容器

@property (nonatomic, weak) IBOutlet UIView *sortHintView; //分类

@property (nonatomic, weak) IBOutlet UIView *brandHintView; //品牌

- (IBAction)clickSortBtn:(id)sender;

- (IBAction)clickBrandBtn:(id)sender;

@end
