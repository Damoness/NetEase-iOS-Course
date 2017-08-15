//
//  MediaItemPickerController.m
//  AudioPlayDemo1
//
//  Created by Chengyin on 16/7/31.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "MediaItemPickerController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MediaItemPickerController ()
{
    NSMutableArray<MPMediaItem *> *_items;
    NSMutableArray<MPMediaItem *> *_selectedItems;
    UIActivityIndicatorView *_waitingView;
}
@end

@implementation MediaItemPickerController

#pragma mark - init & dealloc
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        _items = [NSMutableArray array];
        _selectedItems = [NSMutableArray array];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(selectAllAction:)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(selectFinishedAction:)];
        
        [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(mediaLibraryChanged:) name:MPMediaLibraryDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[MPMediaLibrary defaultMediaLibrary] endGeneratingLibraryChangeNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)selectAllAction:(id)sender
{
    [_selectedItems removeAllObjects];
    [_selectedItems addObjectsFromArray:_items];
    [self.tableView reloadData];
}

- (void)selectFinishedAction:(id)sender
{
    if (_selectedItems.count > 0)
    {
        if ([_delegate respondsToSelector:@selector(mediaItemPicker:didPickMediaItems:)])
        {
            [_delegate mediaItemPicker:self didPickMediaItems:[MPMediaItemCollection collectionWithItems:_selectedItems]];
        }
    }
    [self dismiss];
}

#pragma mark - notification
- (void)mediaLibraryChanged:(NSNotification *)notification
{
    [self fetchItemsAndReload];
}

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"请选择歌曲";
    self.tableView.tableFooterView = [UIView new];
    
    _waitingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.tableView.backgroundView = _waitingView;
    
    [self startLoadMediaItems];
}

- (void)startLoadMediaItems
{
    [_waitingView startAnimating];
    if ([[MPMediaLibrary class] respondsToSelector:@selector(requestAuthorization:)])
    {
        [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
            if (status == MPMediaLibraryAuthorizationStatusAuthorized)
            {
                [self doLoadMediaItems];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:@"未允许访问音乐库" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self dismiss];
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];
    }
    else
    {
        [self doLoadMediaItems];
    }
}

- (void)doLoadMediaItems
{
    [[MPMediaLibrary defaultMediaLibrary] beginGeneratingLibraryChangeNotifications];
    [self fetchItemsAndReload];
}

- (void)fetchItemsAndReload
{
    /**
     *  这部分我们在课程录像的演示中是这么写的：
     *
     *  MPMediaQuery *query = [MPMediaQuery songsQuery];
     *  // 刷新UI
     *
     *  但在实际应用中，当歌曲很多的情况songsQuery方法会消耗一定时间，从而导致UI卡主
     *  所以实际操作是会把这部分操作方到后台线程做，关于线程方面的知识会在后面的课程中讲到
     */
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(reloadMediaItemsInBackground) object:nil];
    [self performSelectorInBackground:@selector(reloadMediaItemsInBackground) withObject:nil];
}

- (void)reloadMediaItemsInBackground
{
    MPMediaQuery *query = [MPMediaQuery songsQuery];
    //子线程加载完成后回到主线程刷新UI
    [self performSelectorOnMainThread:@selector(reloadUIWithQuery:) withObject:query waitUntilDone:YES];
}

- (void)reloadUIWithQuery:(MPMediaQuery *)query
{
    [_waitingView stopAnimating];
    [_items removeAllObjects];
    [_items addObjectsFromArray:query.items];
    [_selectedItems removeAllObjects];
    [self.tableView reloadData];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:^{
        if ([_delegate respondsToSelector:@selector(mediaItemPickerDidCancel:)])
        {
            [_delegate mediaItemPickerDidCancel:self];
        }
    }];
}

#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"itemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    MPMediaItem *item = _items[indexPath.row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",item.artist,item.albumTitle];
    cell.imageView.image = [item.artwork imageWithSize:CGSizeMake(50, 50)];
    cell.accessoryType = [_selectedItems containsObject:item] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    MPMediaItem *item = _items[indexPath.row];
    if ([_selectedItems containsObject:item])
    {
        [_selectedItems removeObject:item];
    }
    else
    {
        [_selectedItems addObject:item];
    }
    [tableView reloadData];
}
@end

