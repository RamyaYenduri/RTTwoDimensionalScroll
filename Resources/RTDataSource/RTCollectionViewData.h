//
//  RTCollectionViewData.h
//  RTTwoDimensionalScroll
//
//  Created by Santhosh on 27/09/16.
//  Copyright © 2016 riktam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RTCollectionViewData : NSObject

@property (nonatomic) NSInteger noOfRows;
@property (nonatomic) NSInteger noOfColumns;

@property (nonatomic,strong) NSArray *cellDetailsArray;
@property (nonatomic,strong) NSArray *rowHeaderDetailsArray;
@property (nonatomic,strong) NSArray *columnHeaderDetailsArray;

@end
