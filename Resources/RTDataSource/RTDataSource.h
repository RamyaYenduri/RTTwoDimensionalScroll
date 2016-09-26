//
//  RTDataSource.h
//  RTTwoDimensionalScroll
//
//  Created by Santhosh on 21/09/16.
//  Copyright © 2016 riktam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RTDataSource : NSObject <UICollectionViewDataSource>

- (instancetype) initWithRowHeaders:(NSArray *)rowHeaderAry columnHeaders:(NSArray *)columnHeaderAry cellDetails:(NSArray *)cellDetailsAry;

@property (nonatomic, strong) NSArray *cellAry;
@property (nonatomic, strong) NSArray *rowHeaderAry;
@property (nonatomic, strong) NSArray *columnHeaderAry;

- (NSInteger)numberOfColumnHeaders;

@end
