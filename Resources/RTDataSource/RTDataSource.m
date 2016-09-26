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

@implementation RTDataSource

- (instancetype)init
{
    return [self initWithRowHeaders:nil columnHeaders:nil cellDetails:nil];
}

- (instancetype) initWithRowHeaders:(NSArray *)rowHeaderAry columnHeaders:(NSArray *)columnHeaderAry cellDetails:(NSArray *)cellDetailsAry
{
    self = [super init];
    if (self) {
        _rowHeaderAry = rowHeaderAry;
        _cellAry = cellDetailsAry;
        _columnHeaderAry = columnHeaderAry;
    }
    return self;
}



#pragma mark - UICOLLECTION VIEW DATA SOURCE

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RTCellIdentifier" forIndexPath:indexPath];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:RTCollectionViewLayoutSupplementaryViewColumnHeader])
    {
        RTColumnHeaderCollectionReusableView *columnView =[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ColumnHeader" forIndexPath:indexPath];
        return columnView;
    }
    
    if ([kind isEqualToString:RTCollectionViewLayoutSupplementaryViewRowHeader])
    {
        RTRowHeaderCollectionReusableView *rowView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"RowHeader" forIndexPath:indexPath];
        return rowView;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.cellAry.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ((NSArray *)self.cellAry[section]).count;
}

- (NSInteger)numberOfColumnHeaders
{
    return self.columnHeaderAry.count;
}


@end
