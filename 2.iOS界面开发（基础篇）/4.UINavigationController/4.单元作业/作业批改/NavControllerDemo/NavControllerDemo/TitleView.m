//
//  TitleView.m
//  NavControllerDemo
//
//  Created by Ashley Han on 27/1/2017.
//  Copyright © 2017 netease. All rights reserved.
//

#import "TitleView.h"

@interface TitleView ()
@property (weak, nonatomic) IBOutlet TitleView *titleBackgroundView;

@end

@implementation TitleView

-(void)awakeFromNib {
    [super awakeFromNib];

    _titleBackgroundView.backgroundColor = [UIColor lightGrayColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
