//
//  GoodsTableViewCell.m
//  Examination_iOS界面开发（基础篇)
//
//  Created by wd on 2017/6/4.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "GoodsTableViewCell.h"

@interface GoodsTableViewCell ()



@end

@implementation GoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.checkButton addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}


-(void)checkAction{
    
    
    self.checkButton.selected = !self.checkButton.selected;
    
    [self updateCheckButton:self.checkButton.selected];
    
    
    if ([self.delegate respondsToSelector:@selector(goodsTableViewCell:checkSelect:)]) {
        
        [self.delegate goodsTableViewCell:self checkSelect:self.checkButton.selected];
        
    }
    
    
    
}




-(void)setDataDic:(NSMutableDictionary *)dataDic{
    
    if (dataDic != nil) {
        _dataDic = dataDic;
        
        _goodsImageView.image = [UIImage imageNamed:_dataDic[@"image"]];
        
        _nameLabel.text = _dataDic[@"name"];
        
        _noLabel.text  = _dataDic[@"no"];
        
        _priceLabel.text = _dataDic[@"price"];
        
        
        [self setCheckSelected:[_dataDic[@"selected"]boolValue]];
         }
    
}

-(void)setCheckSelected:(Boolean)selected{
    
    self.checkButton.selected = selected;
    [self updateCheckButton:selected];
    
}

-(void)updateCheckButton:(Boolean)selected{
    
    
    NSString *imageStr = selected ? @"selection-check":@"selection";
    
    [self.checkButton setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];

}

-(void)setUp{
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
