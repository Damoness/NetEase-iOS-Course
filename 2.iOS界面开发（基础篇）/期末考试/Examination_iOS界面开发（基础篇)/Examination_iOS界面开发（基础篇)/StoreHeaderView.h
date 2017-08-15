//
//  StoreHeaderView.h
//  Examination_iOS界面开发（基础篇)
//
//  Created by wd on 2017/6/4.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoreHeaderView;
@protocol StoreHeaderViewDelegate <NSObject>


-(void)storeHeaderView:(StoreHeaderView *)view checkSelect:(Boolean)selected;

@end

@interface StoreHeaderView : UITableViewHeaderFooterView

@property (strong, nonatomic) IBOutlet UILabel *storeLabel;

@property (strong, nonatomic) IBOutlet UIButton *checkButton;


@property (nonatomic) Boolean selected;

@property (nonatomic) NSInteger section;

@property (weak,nonatomic)id<StoreHeaderViewDelegate>delegate;

@end
