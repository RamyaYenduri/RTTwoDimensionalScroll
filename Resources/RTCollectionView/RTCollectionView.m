//
//  RTCollectionView.m
//  RTTwoDimensionalScroll
//
//  Created by Santhosh on 26/09/16.
//  Copyright © 2016 riktam. All rights reserved.
//

#import "RTCollectionView.h"
#import "RTCollectionViewLayout.h"
#import "RTCollectionViewCell.h"

#import "RTColumnHeaderCollectionReusableView.h"
#import "RTRowHeaderCollectionReusableView.h"
#import "RTCornerCellCollectionReusableView.h"

@interface RTCollectionView() <UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation RTCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    RTCollectionViewLayout *layout = [[RTCollectionViewLayout alloc] init];
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self)
    {
        [self registerTheClasses];
        self.bounces = NO;
        self.delegate = self;
        self.dataSource = self;
    }
    
    return self;
}

- (void)registerTheClasses
{
    [self registerClass:[RTColumnHeaderCollectionReusableView class] forSupplementaryViewOfKind:RTCollectionViewLayoutSupplementaryViewColumnHeader withReuseIdentifier:@"ColumnHeader"];
    [self registerClass:[RTRowHeaderCollectionReusableView class] forSupplementaryViewOfKind:RTCollectionViewLayoutSupplementaryViewRowHeader withReuseIdentifier:@"RowHeader"];
    [self.collectionViewLayout registerClass:[RTCornerCellCollectionReusableView class] forDecorationViewOfKind:RTCollectionViewLayoutSupplementaryViewCornerCell];
    
    [self registerClass:[RTCollectionViewCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
}

#pragma mark - RTCOLLECTION VIEW METHODS

- (RTCollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier ForRTRowcolumnIndex:(struct RTRowColumnIndex)index
{
    return [self dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForRow:index.column inSection:index.row]];
}

- (RTColumnHeaderCollectionReusableView *)dequeueReusableColumnHeaderCellWithReuseIdentifier:(NSString *)identifier AtIndex:(NSInteger)index
{
    return [self dequeueReusableSupplementaryViewOfKind:RTCollectionViewLayoutSupplementaryViewColumnHeader withReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
}

- (RTRowHeaderCollectionReusableView *)dequeueReusableRowHeaderCellWithReuseIdentifier:(NSString *)identifier AtIndex:(NSInteger)index
{
    return [self dequeueReusableSupplementaryViewOfKind:RTCollectionViewLayoutSupplementaryViewRowHeader withReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
}

#pragma mark - UICOLLECTION VIEW DATASOURCE

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([self.rtDataSource respondsToSelector:@selector(numberOfItemsInRow:ForCollectionView:)])
    {
        return [self.rtDataSource numberOfItemsInRow:section ForCollectionView:self];
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if ([self.rtDataSource respondsToSelector:@selector(numberOfRowsForCollectionView:)])
    {
        return [self.rtDataSource numberOfRowsForCollectionView:self];
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    struct RTRowColumnIndex index;
    index.row = indexPath.section;
    index.column = indexPath.row;
    
    return [self.rtDataSource collectionView:self cellForRTRowColumnIndex:index];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:RTCollectionViewLayoutSupplementaryViewColumnHeader])
    {
        return [self.rtDataSource collectionView:self viewForColumnHeaderAtIndex:indexPath.row];
    }
    
    if ([kind isEqualToString:RTCollectionViewLayoutSupplementaryViewRowHeader])
    {
        return [self.rtDataSource collectionView:self viewForRowHeaderAtIndex:indexPath.row];
    }
    
    return nil;
}

#pragma mark - UI COLLECTION VIEW DELEGATE

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    struct RTRowColumnIndex index;
    index.row = indexPath.section;
    index.column = indexPath.row;
    
    [self.rtDelegate collectionView:self didSelectItemAtIndex:index];
}

@end
