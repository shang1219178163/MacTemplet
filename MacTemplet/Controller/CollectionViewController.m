//
//  CollectionViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/18.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "CollectionViewController.h"
#import "NNCollectionView.h"
#import "NSCTViewCellOne.h"
#import "NSCTViewItemOne.h"

@interface CollectionViewController ()<NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NNCollectionView *ctView;
@property (nonatomic, strong) NSArray *content;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.layer.backgroundColor = NSColor.redColor.CGColor;

    [self.view addSubview:self.ctView.enclosingScrollView];

    [self dataSource];
    [self.ctView reloadData];
    
}

- (void)viewDidLayout{
    [super viewDidLayout];
    
    [self.ctView.enclosingScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.ctView.enclosingScrollView.superview);
    }];
}

- (void)dataSource {
    NSArray *array0 = @[NSImageNameQuickLookTemplate, NSImageNameBluetoothTemplate, NSImageNameIChatTheaterTemplate,
                        NSImageNameSlideshowTemplate, NSImageNameActionTemplate ,NSImageNameSmartBadgeTemplate, NSImageNameIconViewTemplate, NSImageNameListViewTemplate, NSImageNameColumnViewTemplate, NSImageNameFlowViewTemplate, NSImageNamePathTemplate, NSImageNameInvalidDataFreestandingTemplate, NSImageNameLockLockedTemplate, NSImageNameLockUnlockedTemplate, NSImageNameGoRightTemplate, NSImageNameGoLeftTemplate, NSImageNameRightFacingTriangleTemplate, NSImageNameLeftFacingTriangleTemplate , NSImageNameAddTemplate, NSImageNameRemoveTemplate, NSImageNameRevealFreestandingTemplate, NSImageNameFollowLinkFreestandingTemplate, NSImageNameEnterFullScreenTemplate, NSImageNameExitFullScreenTemplate, NSImageNameStopProgressTemplate, NSImageNameStopProgressFreestandingTemplate, NSImageNameRefreshTemplate, NSImageNameRefreshFreestandingTemplate, NSImageNameBonjour,NSImageNameComputer, NSImageNameFolderBurnable, NSImageNameFolderSmart, NSImageNameFolder, NSImageNameNetwork];
    
    NSArray *array1 = @[NSImageNameMobileMe, NSImageNameMultipleDocuments, NSImageNameUserAccounts,
                        NSImageNamePreferencesGeneral, NSImageNameAdvanced, NSImageNameInfo,
                        NSImageNameFontPanel, NSImageNameColorPanel, NSImageNameUser,
                        NSImageNameUserGroup, NSImageNameEveryone, NSImageNameUserGuest, NSImageNameMenuOnStateTemplate];
    
    NSArray *array2 = @[NSImageNameMenuMixedStateTemplate, NSImageNameApplicationIcon,NSImageNameTrashEmpty, NSImageNameTrashFull, NSImageNameHomeTemplate,NSImageNameBookmarksTemplate, NSImageNameCaution, NSImageNameStatusAvailable, NSImageNameStatusPartiallyAvailable, NSImageNameStatusUnavailable, NSImageNameStatusNone, NSImageNameShareTemplate];
    
    NSArray *array3 = @[NSImageNameGoRightTemplate, NSImageNameGoLeftTemplate, NSImageNameRightFacingTriangleTemplate, NSImageNameLeftFacingTriangleTemplate];
    
    NSArray *array4 =@[
                       NSImageNameAddTemplate,NSImageNameRemoveTemplate, NSImageNameRevealFreestandingTemplate, NSImageNameFollowLinkFreestandingTemplate, NSImageNameEnterFullScreenTemplate,   NSImageNameExitFullScreenTemplate, NSImageNameStopProgressTemplate, NSImageNameStopProgressFreestandingTemplate, NSImageNameRefreshTemplate, NSImageNameRefreshFreestandingTemplate];
    
    NSArray *array5 = @[NSImageNameBonjour, NSImageNameComputer, NSImageNameFolderBurnable,
                        NSImageNameFolderSmart, NSImageNameFolder, NSImageNameNetwork,];
    
    NSArray *array6 = @[NSImageNameMobileMe, NSImageNameMultipleDocuments, NSImageNameUserAccounts,
                       NSImageNamePreferencesGeneral, NSImageNameAdvanced, NSImageNameInfo,
                       NSImageNameFontPanel, NSImageNameColorPanel, NSImageNameUser,
                       NSImageNameUserGroup, NSImageNameEveryone, NSImageNameUserGuest,
                       NSImageNameMenuOnStateTemplate, NSImageNameMenuMixedStateTemplate,
                        NSImageNameApplicationIcon];
    
    NSArray *array7 = @[NSImageNameTrashEmpty, NSImageNameTrashFull, NSImageNameHomeTemplate,
                       NSImageNameBookmarksTemplate, NSImageNameCaution, NSImageNameStatusAvailable, NSImageNameStatusPartiallyAvailable, NSImageNameStatusUnavailable, NSImageNameStatusNone, NSImageNameShareTemplate];
    
    self.content = @[array0, array1, array2, array3, array4, array5, array6, array7];
    [self.ctView reloadData];
}


#pragma mark -- collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView  {
    return self.content.count;
}

- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray * list = self.content[section];
    return list.count;
}

//-(NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return NSMakeSize(50, 50);
//}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath {
    NSArray * list = self.content[indexPath.section];
    NSString * string = list[indexPath.item];

    NSCTViewCellOne *item = [collectionView makeItemWithIdentifier:@"Slide" forIndexPath:indexPath];
    item.imgView.image = [NSImage imageNamed:string];
    item.label.stringValue = string;

    return item;
}

- (void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths {
//    NSLog(@"----%lu", (unsigned long)collectionView.selectionIndexes.firstIndex);
}


//- (NSView *)collectionView:(NSCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSCollectionViewSupplementaryElementKind)kind atIndexPath:(NSIndexPath *)indexPath{
//
//
//}

#pragma mark -funtions

- (NSCollectionViewFlowLayout *)createFlowLayout{
    NSCollectionViewFlowLayout *layout = [[NSCollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = NSMakeSize(120, 120);
    layout.scrollDirection = NSCollectionViewScrollDirectionVertical;
    layout.sectionInset = NSEdgeInsetsMake(0, 0, 0, 0);
    return layout;
}

#pragma mark -lazy
-(NNCollectionView *)ctView{
    if (!_ctView) {
        _ctView = ({
            NNCollectionView *view = [[NNCollectionView alloc]initWithFrame:self.view.bounds];
            view.collectionViewLayout = [self createFlowLayout];
            [view registerClass:NSCTViewCellOne.class forItemWithIdentifier:@"Slide"];
            view.selectable = true;
            view.dataSource = self;
            view.delegate = self;
            view;
        });
    }
    return _ctView;
}

@end
