//
//  RTDataSource.h
//  RTTwoDimensionalScroll
//
//  Created by Santhosh on 21/09/16.
//  Copyright © 2016 riktam. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RTCollectionView.h"
#import "RTCollectionViewData.h"

@interface RTDataSource : NSObject <RTCollectionViewDataSource>

@property (nonatomic,strong) RTCollectionViewData *collectionViewData;

@end
