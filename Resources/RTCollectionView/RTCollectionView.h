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
@class RTCollectionViewCell;
@class RTRowHeaderCollectionReusableView;
@class RTColumnHeaderCollectionReusableView;

@protocol RTCollectionViewDataSource <NSObject>

- (NSInteger)numberOfRowsForCollectionView:(RTCollectionView *)collectionView;
- (NSInteger)numberOfColumnsForCollectionView:(RTCollectionView *)collectionView;

- (NSInteger)numberOfItemsInRow:(NSInteger)rowNo ForCollectionView:(RTCollectionView *)collectionView;

- (CGSize)sizeForColumnHeadersForCollectionView:(RTCollectionView *)collectionView ForIndex:(NSInteger)index;
- (CGSize)sizeForRowHeadersForCollectionView:(RTCollectionView *)collectionView ForIndex:(NSInteger)index;
- (CGSize)sizeForCellForCollectionView:(RTCollectionView *)collectionView ForIndex:(struct RTRowColumnIndex)index;

- (RTCollectionViewCell *)collectionView:(RTCollectionView *)collectionView cellForRTRowColumnIndex:(struct RTRowColumnIndex)index;
- (RTColumnHeaderCollectionReusableView *)collectionView:(RTCollectionView *)collectionView viewForColumnHeaderAtIndex:(NSInteger)columnIndex;
- (RTRowHeaderCollectionReusableView *)collectionView:(RTCollectionView *)collectionView viewForRowHeaderAtIndex:(NSInteger)columnIndex;

- (UIView *)cornerViewForCollectionView:(RTCollectionView *)collectionView;


@end

@protocol RTCollectionViewDelegate <NSObject>


@end

@interface RTCollectionView : UICollectionView

@property (nonatomic,weak) id<RTCollectionViewDelegate> rtDelegate;
@property (nonatomic,weak) id<RTCollectionViewDataSource> rtDataSource;

- (RTCollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier ForRTRowcolumnIndex:(struct RTRowColumnIndex)index;
- (RTColumnHeaderCollectionReusableView *)dequeueReusableColumnHeaderCellWithReuseIdentifier:(NSString *)identifier AtIndex:(NSInteger)index;
- (RTRowHeaderCollectionReusableView *)dequeueReusableRowHeaderCellWithReuseIdentifier:(NSString *)identifier AtIndex:(NSInteger)index;

@end
