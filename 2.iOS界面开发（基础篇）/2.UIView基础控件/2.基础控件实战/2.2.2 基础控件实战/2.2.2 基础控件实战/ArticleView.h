//
//  ArticleView.h
//  2.2.2 基础控件实战
//
//  Created by 吴狄 on 2017/5/23.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
