//
//  RTCollectionViewLayout.h
//  RTTwoDimensionalScroll
//
//  Created by Santhosh on 08/09/16.
//  Copyright © 2016 riktam. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const RTCollectionViewLayoutSupplementaryViewColumnHeader;
extern NSString *const RTCollectionViewLayoutSupplementaryViewRowHeader;
extern NSString *const RTCollectionViewLayoutSupplementaryViewCornerCell;


@interface RTCollectionViewLayout : UICollectionViewLayout

@property (nonatomic) CGSize cellSize;
@property (nonatomic) CGFloat columnHeaderHeight;
@property (nonatomic) CGFloat rowHeaderWidth;

@end


@protocol RTCollectionViewLayoutDelegate <NSObject>
@optional
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(RTCollectionViewLayout *)layout sizeForCellAtIndexPath:(NSIndexPath *)indexPath;
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(RTCollectionViewLayout *)layout supplementaryViewOfKind:(NSString *)kind sizeAtIndexPath:(NSIndexPath *)indexPath;

@end