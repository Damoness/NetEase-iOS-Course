//
//  MyImagePickerViewController.m
//  PhotoFrameworkDemo
//
//  Created by Chengyin on 16/9/11.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "MyImagePickerViewController.h"
#import "MyImagePickAlbumsViewController.h"
#import "MyImagePreviewViewController.h"
#import "MyImagePickerCell.h"
#import "PHAsset+FetchImage.h"
#import <Photos/Photos.h>

static const CGFloat itemSpacing = 5;
static const NSUInteger itemPerRow = 4;

@interface MyImagePickerViewController ()<MyImagePickAlbumsViewControllerDelegate,MyImagePickerCellDelegate,MyImagePreviewViewControllerDelegate,PHPhotoLibraryChangeObserver>
{
    NSMutableArray<PHAssetCollection *> *_albums;
    NSMutableArray<PHFetchResult<PHAssetCollection *> *> *_albumResults;
    PHFetchResult<PHAsset *> *_assets;
    NSMutableArray<PHAsset *> *_selectedAssets;
}
@property (nonatomic,strong) PHAssetCollection *currentAlbum;
@end

@implementation MyImagePickerViewController

static NSString * const reuseIdentifier = @"Cell";

#pragma mark - dealloc & init
- (void)dealloc
{
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

- (instancetype)init
{
    CGFloat size = ([[UIScreen mainScreen] bounds].size.width - itemSpacing * (itemPerRow + 1)) / itemPerRow;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(size, size);
    layout.sectionInset = UIEdgeInsetsMake(itemSpacing, 0, 0, 0);
    layout.minimumInteritemSpacing = itemSpacing;
    layout.minimumLineSpacing = itemSpacing;
    self = [self initWithCollectionViewLayout:layout];
    if (self)
    {
        _albums = [NSMutableArray array];
        _albumResults = [NSMutableArray array];
        _selectedAssets = [NSMutableArray array];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"albums" style:UIBarButtonItemStylePlain target:self action:@selector(albumsAction:)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Finish" style:UIBarButtonItemStylePlain target:self action:@selector(finishAction:)];
    }
    return self;
}

#pragma mark - navigation item actions
- (void)albumsAction:(id)sender
{
    if (_albums.count == 0)
    {
        return;
    }
    
    MyImagePickAlbumsViewController *albumsViewController = [[MyImagePickAlbumsViewController alloc] initWithAssetCollections:_albums];
    albumsViewController.delegate = self;
    [self.navigationController pushViewController:albumsViewController animated:YES];
}

- (void)finishAction:(id)sender
{
    if ([_delegate respondsToSelector:@selector(imagePickerViewController:didSelectAssets:)])
    {
        [_delegate imagePickerViewController:self didSelectAssets:[_selectedAssets copy]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickAlbumsViewController:(MyImagePickAlbumsViewController *)imagePickAlbumsViewController didSelectAlbum:(PHAssetCollection *)album
{
    self.currentAlbum = album;
}

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.backgroundView = nil;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.allowsMultipleSelection = YES;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, itemSpacing, 0, itemSpacing);
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[MyImagePickerCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self requestAuthorization:^(PHAuthorizationStatus status) {
        //main thread
        [self performSelectorOnMainThread:@selector(requestAuthorizationFinished:) withObject:@(status) waitUntilDone:NO];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - permission
- (void)requestAuthorization:(void(^)(PHAuthorizationStatus status))handler;
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined)
    {
        [PHPhotoLibrary requestAuthorization:handler];
    }
    else if (handler)
    {
        handler(status);
    }
}

- (void)requestAuthorizationFinished:(NSNumber *)status
{
    if ([status integerValue] == PHAuthorizationStatusAuthorized)
    {
        [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
        [self reloadAlbums];
    }
    else
    {
        //handle error
    }
}

#pragma mark - change
- (void)photoLibraryDidChange:(PHChange *)changeInstance
{
    BOOL shouldReloadAlbum = NO;
    for (PHFetchResult<PHAssetCollection *> *result in _albumResults)
    {
        PHFetchResultChangeDetails *change = [changeInstance changeDetailsForFetchResult:result];
        if (change)
        {
            shouldReloadAlbum = YES;
            break;
        }
    }
    
    if (shouldReloadAlbum)
    {
        [self reloadAlbums];
    }
    else
    {
        [self reloadAssets];
    }
}

#pragma mark - albums
- (void)loadAlbums:(void(^)(void))finished
{
    [_albums removeAllObjects];
    [_albumResults removeAllObjects];
    PHFetchResult<PHAssetCollection *> *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    [result enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj)
        {
            [_albums addObject:obj];
        }
    }];
    if (result)
    {
        [_albumResults addObject:result];
    }
    
    result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
    [result enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj)
        {
            [_albums addObject:obj];
        }
    }];
    if (result)
    {
        [_albumResults addObject:result];
    }
    
    if (finished)
    {
        finished();
    }
}

- (void)reloadAlbums
{
    [self loadAlbums:^{
        self.currentAlbum = [_albums firstObject];
    }];
}

- (void)setCurrentAlbum:(PHAssetCollection *)currentAlbum
{
    if (_currentAlbum == currentAlbum)
    {
        return;
    }
    _currentAlbum = currentAlbum;
    self.title = _currentAlbum.localizedTitle;
    [self reloadAssets];
}

#pragma mark - assets
- (void)loadAssets:(void(^)(void))finished
{
    if (!_currentAlbum)
    {
        if (finished)
        {
            finished();
        }
        return;
    }
    
    [_selectedAssets removeAllObjects];
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %i",PHAssetMediaTypeImage];
    _assets = [PHAsset fetchAssetsInAssetCollection:_currentAlbum options:options];
    
    if (finished)
    {
        finished();
    }
}

- (void)reloadAssets
{
    [self performSelectorInBackground:@selector(doReloadAssets) withObject:nil];
}

- (void)doReloadAssets
{
    [self loadAssets:^{
        [self performSelectorOnMainThread:@selector(reloadAssetsFinished) withObject:nil waitUntilDone:NO];
    }];
}

- (void)reloadAssetsFinished
{
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PHAsset *asset = [_assets objectAtIndex:indexPath.item];
    MyImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.image = [asset fi_aspectThumbnailImageWithSize:[(UICollectionViewFlowLayout *)collectionView.collectionViewLayout itemSize]];
    cell.userSelected = [_selectedAssets containsObject:asset];
    return cell;
}

- (void)imagePickerCellCheckBoxClicked:(MyImagePickerCell *)cell
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    PHAsset *asset = [_assets objectAtIndex:indexPath.item];
    [self selectOrDeselectAsset:asset];
}

- (void)selectOrDeselectAsset:(PHAsset *)asset
{
    if ([_selectedAssets containsObject:asset])
    {
        [_selectedAssets removeObject:asset];
    }
    else
    {
        [_selectedAssets addObject:asset];
    }
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    PHAsset *asset = [_assets objectAtIndex:indexPath.item];
    MyImagePreviewViewController *previewViewController = [[MyImagePreviewViewController alloc] initWithAsset:asset];
    previewViewController.delegate = self;
    [self.navigationController pushViewController:previewViewController animated:YES];
}

- (void)imagePreviewViewControllerDidSelectImage:(MyImagePreviewViewController *)imagePreviewViewController
{
    PHAsset *asset = imagePreviewViewController.asset;
    [self selectOrDeselectAsset:asset];
}
@end
