//
//  RTRowHeaderCollectionReusableView.h
//  RTTwoDimensionalScroll
//
//  Created by Santhosh on 21/09/16.
//  Copyright © 2016 riktam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTRowHeaderDetails.h"

@interface RTRowHeaderCollectionReusableView : UICollectionReusableView

@property (nonatomic,strong) RTRowHeaderDetails *rowHeaderDetail;

@end
