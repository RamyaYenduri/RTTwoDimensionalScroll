//
//  RTDataSource.m
//  RTTwoDimensionalScroll
//
//  Created by Santhosh on 21/09/16.
//  Copyright © 2016 riktam. All rights reserved.
//

#import "RTDataSource.h"

#import "RTCollectionViewCell.h"
#import "RTColumnHeaderCollectionReusableView.h"
#import "RTRowHeaderCollectionReusableView.h"
#import "RTCollectionViewLayout.h"

#import "RTCellDetails.h"

@implementation RTDataSource

@synthesize collectionViewData;
#pragma mark - RTCOLLECTION VIEW DATA SOURCE

- (NSInteger)numberOfRowsForCollectionView:(RTCollectionView *)collectionView
{
    return collectionViewData.noOfRows;
}

- (NSInteger)numberOfColumnsForCollectionView:(RTCollectionView *)collectionView
{
    return collectionViewData.noOfColumns;
}

- (NSInteger)numberOfItemsInRow:(NSInteger)rowNo ForCollectionView:(RTCollectionView *)collectionView
{
    return [[collectionViewData.cellDetailsArray objectAtIndex:rowNo] count];
}

- (CGSize)sizeForColumnHeadersForCollectionView:(RTCollectionView *)collectionView
{
    return collectionViewData.coulumnHeaderSize;
}

- (CGSize)sizeForRowHeadersForCollectionView:(RTCollectionView *)collectionView
{
    return collectionViewData.rowHeaderSize;
}

- (CGSize)sizeForCellForCollectionView:(RTCollectionView *)collectionView ForIndex:(struct RTRowColumnIndex)index
{
    return [(RTCellDetails *)[[collectionViewData.cellDetailsArray objectAtIndex:index.row] objectAtIndex:index.column] cellSize];
}

- (RTCollectionViewCell *)collectionView:(RTCollectionView *)collectionView cellForRTRowColumnIndex:(struct RTRowColumnIndex)index
{
    RTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"" ForRTRowcolumnIndex:index];
    cell.cellDetail = [[collectionViewData.cellDetailsArray objectAtIndex:index.row] objectAtIndex:index.column];
    
    return cell;
}

- (RTColumnHeaderCollectionReusableView *)collectionView:(RTCollectionView *)collectionView viewForColumnHeaderAtIndex:(NSInteger)columnIndex
{
    RTColumnHeaderCollectionReusableView *cell = [collectionView dequeueReusableColumnHeaderCellWithReuseIdentifier:@"" AtIndex:columnIndex];
    cell.columnHeaderDetail = [collectionViewData.columnHeaderDetailsArray objectAtIndex:columnIndex];
   
    return cell;
}

- (RTRowHeaderCollectionReusableView *)collectionView:(RTCollectionView *)collectionView viewForRowHeaderAtIndex:(NSInteger)columnIndex
{
    RTRowHeaderCollectionReusableView *cell = [collectionView dequeueReusableRowHeaderCellWithReuseIdentifier:@"" AtIndex:columnIndex];
    cell.rowHeaderDetail = [collectionViewData.rowHeaderDetailsArray objectAtIndex:columnIndex];
    
    return nil;
}

- (UIView *)cornerViewForCollectionView:(RTCollectionView *)collectionView
{
    return nil;
}

@end
