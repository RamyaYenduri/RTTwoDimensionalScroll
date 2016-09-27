//
//  RTColumnHeaderCollectionReusableView.h
//  RTTwoDimensionalScroll
//
//  Created by Santhosh on 21/09/16.
//  Copyright © 2016 riktam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTColumnHeaderDetails.h"

@interface RTColumnHeaderCollectionReusableView : UICollectionReusableView

@property (nonatomic,strong) RTColumnHeaderDetails *columnHeaderDetail;

@end
