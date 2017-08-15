//
//  StoreHeaderView.m
//  Examination_iOS界面开发（基础篇)
//
//  Created by wd on 2017/6/4.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "StoreHeaderView.h"




@implementation StoreHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.checkButton addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    
   // self.checkButton.selected = NO;
   // [self updateCheckButton:self.checkButton.selected];
    
}


-(void)setSelected:(Boolean)selected{
    
    self.checkButton.selected = selected;
    [self updateCheckButton:selected];
    
}


-(void)updateCheckButton:(Boolean)selected{
    
    
    NSString *imageStr = selected ? @"selection-check":@"selection";
    
    [self.checkButton setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    
}

-(void)checkAction{
    
    
    self.checkButton.selected = !self.checkButton.selected;
    
    [self updateCheckButton:self.checkButton.selected];
    
    if ([self.delegate respondsToSelector:@selector(storeHeaderView:checkSelect:)]) {
        
        [self.delegate storeHeaderView:self checkSelect:self.checkButton.selected];
        
    }
    

    
    
    
}


@end
