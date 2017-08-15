//
//  GoodsTableViewCell.h
//  Examination_iOS界面开发（基础篇)
//
//  Created by wd on 2017/6/4.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsTableViewCell;

@protocol GoodsTableViewCellDelegate <NSObject>

-(void)goodsTableViewCell:(GoodsTableViewCell *)cell checkSelect:(Boolean)selected;


@end

@interface GoodsTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *noLabel;

@property (strong, nonatomic) IBOutlet UIImageView *goodsImageView;

@property (strong, nonatomic) IBOutlet UIButton *checkButton;

@property (nonatomic) Boolean checkSelected;

@property (strong , nonatomic) NSMutableDictionary *dataDic;

@property (weak,nonatomic) id<GoodsTableViewCellDelegate>delegate;
@end
