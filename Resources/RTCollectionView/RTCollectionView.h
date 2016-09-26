//
//  RTCollectionView.h
//  RTTwoDimensionalScroll
//
//  Created by Santhosh on 26/09/16.
//  Copyright © 2016 riktam. All rights reserved.
//

#import <UIKit/UIKit.h>

struct RTRowColumnIndex {
    NSInteger row;
    NSInteger column;
};

@class RTCollectionViewLayout;
@class RTCollectionView;

@protocol RTCollectionViewDataSource <UICollectionViewDataSource>

- (NSInteger)numberOfRowsForCollectionView:(RTCollectionView *)collectionView;
- (NSInteger)numberOfColumnsForCollectionView:(RTCollectionView *)collectionView;

- (NSInteger)numberOfItemsInRow:(NSInteger)rowNo ForCollectionView:(RTCollectionView *)collectionView;

- (CGSize)sizeForColumnHeadersForCollectionView:(RTCollectionView *)collectionView;
- (CGSize)sizeForRowHeadersForCollectionView:(RTCollectionView *)collectionView;
- (CGSize)sizeForCellForCollectionView:(RTCollectionView *)collectionView ForIndex:(struct RTRowColumnIndex)index;

- (UIView *)rowHeaderViewForRow:(NSInteger)row ForCollectionView:(RTCollectionView *)collectionView;
- (UIView *)columnHeaderViewForColumn:(NSInteger)column ForCollectionView:(RTCollectionView *)collectionView;
- (UIView *)cornerViewForCollectionView:(RTCollectionView *)collectionView;

- (CGSize) collectionView:(RTCollectionView *)collectionView layout:(RTCollectionViewLayout *)layout sizeForCellAtIndex:(struct RTRowColumnIndex)index;
- (CGSize) collectionView:(RTCollectionView *)collectionView layout:(RTCollectionViewLayout *)layout supplementaryViewOfKind:(NSString *)kind sizeAtIndex:(NSInteger)index;

@end

@protocol RTCollectionViewDelegate <UICollectionViewDelegate>


@end

@interface RTCollectionView : UICollectionView

@property (nonatomic,weak) id<RTCollectionViewDelegate> delegate;
@property (nonatomic,weak) id<RTCollectionViewDataSource> dataSource;


@end
