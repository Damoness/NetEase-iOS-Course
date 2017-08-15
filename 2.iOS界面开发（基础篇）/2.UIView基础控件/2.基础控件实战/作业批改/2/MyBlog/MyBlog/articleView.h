//
//  articleView.h
//  MyBlog
//
//  Created by jele lam on 2/6/2017.
//  Copyright © 2017年 jele lam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface articleView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
