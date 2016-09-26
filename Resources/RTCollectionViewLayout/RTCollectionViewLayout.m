//
//  RTCollectionViewLayout.m
//  RTTwoDimensionalScroll
//
//  Created by Santhosh on 08/09/16.
//  Copyright © 2016 riktam. All rights reserved.
//

#import "RTCollectionViewLayout.h"
#import "RTDataSource.h"

NSString *const RTCollectionViewLayoutSupplementaryViewColumnHeader = @"RTCollectionViewLayoutSupplementaryViewColumnHeader";
NSString *const RTCollectionViewLayoutSupplementaryViewRowHeader = @"RTCollectionViewLayoutSupplementaryViewRowHeader";
NSString *const RTCollectionViewLayoutSupplementaryViewCornerCell = @"RTCollectionViewLayoutSupplementaryViewCornerCell";

#pragma mark - RTViewCollectionViewSizing

@interface RTViewCollectionViewSizing : NSObject

- (CGFloat) widthForColumn:(NSUInteger)column;
- (CGFloat) heightForRow:(NSUInteger)row;
- (void) setWidth:(CGFloat)width forColumn:(NSUInteger)column;
- (void) setHeight:(CGFloat)height forRow:(NSUInteger)row;

@end

@interface RTViewCollectionViewSizing ()

@property (nonatomic, strong) NSMutableDictionary *rows;
@property (nonatomic, strong) NSMutableDictionary *columns;
@property (nonatomic) CGFloat columnHeaderHeight;
@property (nonatomic) CGFloat rowHeaderWidth;

@end

@implementation RTViewCollectionViewSizing

- (instancetype) init {
    if (self = [super init]) {
        _rows = [[NSMutableDictionary alloc] init];
        _columns = [[NSMutableDictionary alloc] init];
        _columnHeaderHeight = 0;
        _rowHeaderWidth = 0;
    }
    
    return self;
}

- (CGFloat) widthForColumn:(NSUInteger)column {
    return [[self.columns objectForKey:@(column)] floatValue];
}

- (CGFloat) heightForRow:(NSUInteger)row {
    return [[self.rows objectForKey:@(row)] floatValue];
}

- (void) setWidth:(CGFloat)width forColumn:(NSUInteger)column {
    self.columns[@(column)] = @(width);
}

- (void) setHeight:(CGFloat)height forRow:(NSUInteger)row {
    self.rows[@(row)] = @(height);
}

@end

#pragma mark - BLCollectionViewTableLayoutInvalidationContext
@interface RTCollectionViewLayoutInvalidationContext : UICollectionViewFlowLayoutInvalidationContext

@property (nonatomic) BOOL useCachedSizing;

@end

@implementation RTCollectionViewLayoutInvalidationContext

@end

#pragma mark - RTCollectionViewLayout

@interface RTCollectionViewLayout ()

@property (nonatomic) CGSize collectionViewContentSize;
@property (nonatomic,strong) NSArray *cellAttribute;
@property (nonatomic,strong) NSDictionary *supplementaryAttribute;
@property (nonatomic,strong) NSDictionary * decorationAttributes;
@property (nonatomic,strong) RTViewCollectionViewSizing *tableSizing;
@property (nonatomic) BOOL skipBuildingCellAttributes;
@property (nonatomic) BOOL hasRegisteredCellCornerDecorationView;

@end

@implementation RTCollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (void)setup
{
    _cellSize = CGSizeMake(100,100);
    _rowHeaderWidth = 0.0f;
    _columnHeaderHeight = 0.0f;
    _collectionViewContentSize = CGSizeZero;
}

#pragma mark - UICOLLECTION VIEW LAYOUT OVERRIDES

- (void)registerClass:(Class)viewClass forDecorationViewOfKind:(NSString *)elementKind
{
    [super registerClass:viewClass forDecorationViewOfKind:elementKind];
    if([elementKind isEqualToString:RTCollectionViewLayoutSupplementaryViewCornerCell])
    {
        self.hasRegisteredCellCornerDecorationView = viewClass != nil;
    }
}

- (void)prepareLayout
{
    [super prepareLayout];
    if (self.collectionView.dataSource != nil) {
        [self buildLayoutAttributes];
        if(CGSizeEqualToSize(self.collectionViewContentSize,CGSizeZero))
        {
            [self buildCollectionViewContentSize];
        }
    }
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellAttribute[indexPath.section][indexPath.row];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    return self.supplementaryAttribute[elementKind][indexPath];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    return self.decorationAttributes[elementKind][indexPath];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    if (self.collectionView.dataSource == nil) {
        return  nil;
    }
    NSMutableArray *elements = [[NSMutableArray alloc] init];
    
    for (NSArray *rows in self.cellAttribute) {
        for (UICollectionViewLayoutAttributes *attributes in rows) {
            if (CGRectIntersectsRect(rect,attributes.frame)) {
                [elements addObject:attributes];
            }
        }
    }
    
    void(^handler)(id key , UICollectionViewLayoutAttributes *attributes , BOOL *stop) = ^(id key , UICollectionViewLayoutAttributes *attributes, BOOL *stop){
        if(CGRectIntersectsRect(rect,attributes.frame))
        {
            [elements addObject:attributes];
        }
    };
    
    [self.supplementaryAttribute[RTCollectionViewLayoutSupplementaryViewColumnHeader] enumerateKeysAndObjectsUsingBlock:handler];
    [self.supplementaryAttribute[RTCollectionViewLayoutSupplementaryViewRowHeader] enumerateKeysAndObjectsUsingBlock:handler];
    [self.decorationAttributes[RTCollectionViewLayoutSupplementaryViewCornerCell] enumerateKeysAndObjectsUsingBlock:handler];
    
    
    return [elements copy];
}

#pragma mark - Handling Bounds Changes

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    if([self hasHeaderSizing])
    {
        CGPoint origin = self.collectionView.bounds.origin;
        CGPoint neworigin = newBounds.origin;
        CGFloat xDiff = neworigin.x - origin.x;
        CGFloat yDiff = neworigin.y - origin.y;
        
        if((fabs(xDiff) > FLT_EPSILON && [self hasRowHeaderSizing]) || (fabs(yDiff) > FLT_EPSILON && [self hasColumnHeaderSizing]) )
        {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Invalidation Contexts

- (UICollectionViewLayoutInvalidationContext *)invalidationContextForBoundsChange:(CGRect)newBounds
{
    RTCollectionViewLayoutInvalidationContext *context = (RTCollectionViewLayoutInvalidationContext *)[super invalidationContextForBoundsChange:newBounds];
    context.useCachedSizing = YES;
    return context;
}

+ (Class)invalidationContextClass
{
    return [RTCollectionViewLayoutInvalidationContext class];
}

#define Accessor Overrides

- (RTViewCollectionViewSizing *)tableSizing
{
    _tableSizing = [self createTableSizing];
    return _tableSizing;
}

#pragma mark - Developer methods

- (void)buildCollectionViewContentSize
{
    CGFloat width = 0.0f;
    CGFloat height = 0.0f;
    
    NSUInteger sections = [self.collectionView numberOfSections];
    
    if(sections > 0)
    {
        NSUInteger lastRowCells = [self.collectionView numberOfItemsInSection:sections - 1];
        if(lastRowCells > 0)
        {
            UICollectionViewLayoutAttributes *lastAttributes = self.cellAttribute[sections - 1][lastRowCells - 1];
            height = CGRectGetMaxY(lastAttributes.frame);
        }
        NSUInteger cells = [self.collectionView numberOfItemsInSection:sections - 1 ];
        if (cells > 0) {
            UICollectionViewLayoutAttributes *attributes = self.cellAttribute[sections - 1][cells - 1];
            width = MAX(width,CGRectGetMaxX(attributes.frame));
        }
        
    }
    
    self.collectionViewContentSize = CGSizeMake(roundf(width),height);
}

#pragma mark - Building layout attributes

- (void)buildLayoutAttributes
{
    if (!self.skipBuildingCellAttributes) {
        [self clearLayoutAttributes];
        [self buildCellAttributes];
    }
    else
    {
        self.skipBuildingCellAttributes = NO;
    }
    [self buildSupplementaryAttributes];
    [self buildDecorationAttributes];
}

- (void)buildCellAttributes
{
    RTViewCollectionViewSizing *sizing = self.tableSizing;
    NSMutableArray *tmpAttributes = [[NSMutableArray alloc] init];
    CGFloat yOffset = sizing.columnHeaderHeight;
    NSUInteger sections = [self.collectionView numberOfSections];
    
    for (NSUInteger section = 0; section != sections; section++) {
        NSUInteger rows = [self.collectionView numberOfItemsInSection:section];
        CGFloat xOffset = sizing.rowHeaderWidth;
        CGFloat height = [sizing heightForRow:section];
        
        NSMutableArray *tmpRowAttributes = [[NSMutableArray alloc] init];
        for (NSUInteger row = 0; row != rows; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            
            CGSize size = [((id<RTCollectionViewLayoutDelegate>)self.collectionView.delegate) collectionView:self.collectionView layout:self sizeForCellAtIndexPath:indexPath];
            CGFloat width = size.width;
            
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = CGRectMake(xOffset, yOffset, width, height);
            [tmpRowAttributes addObject:attributes];
            xOffset += width;
        }
        
        [tmpAttributes addObject:tmpRowAttributes];
        
        yOffset += height;
    }
    self.cellAttribute = tmpAttributes;
}

- (void) buildSupplementaryAttributes {
    
    RTViewCollectionViewSizing *sizing = self.tableSizing;
    
    NSMutableDictionary *rowHeaderAttributes = self.supplementaryAttribute[RTCollectionViewLayoutSupplementaryViewRowHeader] ?: [NSMutableDictionary dictionary];
    
    NSMutableDictionary *columnHeaderAttributes = self.supplementaryAttribute[RTCollectionViewLayoutSupplementaryViewColumnHeader] ?: [NSMutableDictionary dictionary];
    
    if (sizing.columnHeaderHeight > 0 || sizing.rowHeaderWidth > 0)
    {
        NSUInteger maximumRows = 0;
        CGFloat yOffset = sizing.columnHeaderHeight;
        NSUInteger sections = [self.collectionView numberOfSections];
        
        for (NSUInteger section = 0; section != sections; section++)
        {
            NSUInteger rows = [self.collectionView numberOfItemsInSection:section];
            maximumRows = MAX(maximumRows,rows);
            
            if (sizing.rowHeaderWidth > 0)
            {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
                UICollectionViewLayoutAttributes * attributes2 = rowHeaderAttributes[indexPath]?:[UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:RTCollectionViewLayoutSupplementaryViewRowHeader withIndexPath:indexPath];
                CGFloat height = [sizing heightForRow:section];
                CGFloat xOffset = CGRectGetMinX(self.collectionView.bounds) + self.collectionView.contentInset.left;
                attributes2.frame = CGRectMake(xOffset, yOffset, sizing.rowHeaderWidth, height);
                attributes2.zIndex = 100;
                rowHeaderAttributes[indexPath] = attributes2;
                yOffset += height;
            }
        }
        maximumRows = [(RTDataSource *)self.collectionView.dataSource numberOfColumnHeaders];
        if (sizing.columnHeaderHeight > 0)
        {
            CGFloat xOffset = sizing.rowHeaderWidth;
            
            for (NSUInteger row = 0 ; row != maximumRows ; row++ )
            {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
                UICollectionViewLayoutAttributes *attributes = columnHeaderAttributes[indexPath]?:[UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:RTCollectionViewLayoutSupplementaryViewColumnHeader withIndexPath:indexPath];
                CGFloat width = [sizing widthForColumn:row];
                CGFloat yOffset = CGRectGetMinY(self.collectionView.bounds) + self.collectionView.contentInset.top;
                attributes.frame = CGRectMake(xOffset,yOffset,width,sizing.columnHeaderHeight);
                attributes.zIndex = 200;
                columnHeaderAttributes[indexPath] = attributes;
                xOffset += width;
            }
            
        }
    }
    self.supplementaryAttribute = @{RTCollectionViewLayoutSupplementaryViewColumnHeader : columnHeaderAttributes,RTCollectionViewLayoutSupplementaryViewRowHeader : rowHeaderAttributes};
    
}

- (void)buildDecorationAttributes
{
    RTViewCollectionViewSizing *sizing = self.tableSizing;
    
    NSMutableDictionary *cellCornerAttributes = [NSMutableDictionary dictionary];
    
    if (self.hasRegisteredCellCornerDecorationView && sizing.columnHeaderHeight > 0 && sizing.rowHeaderWidth > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:RTCollectionViewLayoutSupplementaryViewCornerCell withIndexPath:indexPath];
        CGFloat x = CGRectGetMinX(self.collectionView.bounds) + self.collectionView.contentInset.left;
        CGFloat y = CGRectGetMinY(self.collectionView.bounds) + self.collectionView.contentInset.top;
        attributes.frame = CGRectMake(x, y, sizing.rowHeaderWidth, sizing.columnHeaderHeight);
        attributes.zIndex = 500;
        cellCornerAttributes[indexPath] = attributes;
    }
    
    self.decorationAttributes = @{RTCollectionViewLayoutSupplementaryViewCornerCell: cellCornerAttributes};
}

#pragma mark - Sizing

- (RTViewCollectionViewSizing *)createTableSizing
{
    RTViewCollectionViewSizing *sizing = [[RTViewCollectionViewSizing alloc] init];
    NSUInteger sections = [self.collectionView numberOfSections];
    
    BOOL delegatesHeaderSizing = (self.collectionView.delegate) && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:supplementaryViewOfKind:sizeAtIndexPath:)];
    
    if (delegatesHeaderSizing)
    {
        sizing.rowHeaderWidth = self.rowHeaderWidth;
        sizing.columnHeaderHeight = self.columnHeaderHeight;
    }
    
    for (NSUInteger section = 0 ; section != sections ; section++)
    {
        
        if (delegatesHeaderSizing)
        {
            CGSize size = [((id<RTCollectionViewLayoutDelegate>)self.collectionView.delegate) collectionView:self.collectionView layout:self supplementaryViewOfKind:RTCollectionViewLayoutSupplementaryViewRowHeader sizeAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
            if(sizing.rowHeaderWidth < size.width)
            {
                sizing.rowHeaderWidth = size.width;
            }
            
            [sizing setHeight:size.height forRow:section];
            
        }
    }
    NSUInteger rows = [(RTDataSource *)self.collectionView.dataSource numberOfColumnHeaders];
    
    for (NSUInteger row = 0 ; row != rows ; row++)
    {
        if (delegatesHeaderSizing)
        {
            CGSize size = [((id<RTCollectionViewLayoutDelegate>)self.collectionView.delegate) collectionView:self.collectionView layout:self supplementaryViewOfKind:RTCollectionViewLayoutSupplementaryViewColumnHeader sizeAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
            
            if (sizing.columnHeaderHeight < size.height)
            {
                sizing.columnHeaderHeight = size.height;
            }
            
            if ([sizing widthForColumn:row] < size.width)
            {
                [sizing setWidth:size.width forColumn:row];
            }
        }
    }
    
    return sizing;
}

- (BOOL) hasHeaderSizing {
    return [self hasColumnHeaderSizing] || [self hasRowHeaderSizing];
}

- (BOOL) hasColumnHeaderSizing {
    return [self.supplementaryAttribute[RTCollectionViewLayoutSupplementaryViewColumnHeader] count] > 0;
}

- (BOOL) hasRowHeaderSizing {
    return [self.supplementaryAttribute[RTCollectionViewLayoutSupplementaryViewRowHeader] count] > 0;
}

- (void) clearLayoutAttributes {
    self.cellAttribute = nil;
    self.supplementaryAttribute = nil;
    self.decorationAttributes = nil;
}

@end
