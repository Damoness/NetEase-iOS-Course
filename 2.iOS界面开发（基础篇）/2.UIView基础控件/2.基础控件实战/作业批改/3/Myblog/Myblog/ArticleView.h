//
//  ArticleView.h
//  Myblog
//
//  Created by 江宝敏 on 2017/5/29.
//  Copyright © 2017年 江宝敏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
