//
//  ArticleView.h
//  MyBlog
//
//  Created by CyouGuang on 17/5/29.
//  Copyright © 2017年 CyouGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
