//
//  TestMediaPickerViewController.m
//  AudioPlayDemo1
//
//  Created by Chengyin on 16/8/1.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "TestMediaPickerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TestMediaPickerViewController ()<MPMediaPickerControllerDelegate>

@end

@implementation TestMediaPickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Media Picker";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self pickFromSystemMediaPicker];
}

- (void)pickFromSystemMediaPicker
{
    MPMediaPickerController *pickerController = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    pickerController.delegate = self;
    pickerController.allowsPickingMultipleItems = YES;
    pickerController.prompt = @"请选择歌曲";
    [self presentViewController:pickerController animated:YES completion:nil];
}


- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    NSArray<MPMediaItem *> *items = mediaItemCollection.items;
    for (MPMediaItem *item in items)
    {
        NSLog(@"%@",item.title);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    NSLog(@"cancelled");
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
