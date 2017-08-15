//
//  LogCollectionViewCell.h
//  NetEaseTest_SimpleLog
//
//  Created by _Sharuru on 2017/6/2.
//  Copyright © 2017年 KarinoSharuru. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LogModel;

@interface LogCollectionViewCell : UICollectionViewCell

/// model
@property(nonatomic, weak) LogModel *model;

@end
