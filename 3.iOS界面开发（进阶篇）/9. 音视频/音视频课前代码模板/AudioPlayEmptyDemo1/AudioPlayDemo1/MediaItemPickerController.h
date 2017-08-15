//
//  MediaItemPickerController.h
//  AudioPlayDemo1
//
//  Created by Chengyin on 16/7/31.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPMediaItemCollection;
@class MediaItemPickerController;
@protocol MediaItemPickerControllerDelegate <NSObject>
@optional
- (void)mediaItemPicker:(MediaItemPickerController *)mediaItemPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection;
- (void)mediaItemPickerDidCancel:(MediaItemPickerController *)mediaItemPicker;
@end

@interface MediaItemPickerController : UITableViewController

@property (nonatomic,weak) id<MediaItemPickerControllerDelegate> delegate;

@end
