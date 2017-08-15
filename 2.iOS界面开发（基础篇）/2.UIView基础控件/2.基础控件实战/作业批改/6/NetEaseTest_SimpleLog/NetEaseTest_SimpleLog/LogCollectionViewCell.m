//
//  LogCollectionViewCell.m
//  NetEaseTest_SimpleLog
//
//  Created by _Sharuru on 2017/6/2.
//  Copyright © 2017年 KarinoSharuru. All rights reserved.
//

#import "LogCollectionViewCell.h"
#import "LogModel.h"

@interface LogCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation LogCollectionViewCell

- (void)setModel:(LogModel *)model {
    _model = model;
    _contentLabel.text = model.content;
    _timeLabel.text = model.time;
    _model = model;
}

@end
