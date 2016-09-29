//
//  RTColumnHeaderCollectionReusableView.m
//  RTTwoDimensionalScroll
//
//  Created by Santhosh on 21/09/16.
//  Copyright © 2016 riktam. All rights reserved.
//

#import "RTColumnHeaderCollectionReusableView.h"

@implementation RTColumnHeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor grayColor];
    }
    
    return self;
}

@end
