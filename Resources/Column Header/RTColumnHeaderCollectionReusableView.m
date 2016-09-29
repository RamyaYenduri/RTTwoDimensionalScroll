//
//  RTColumnHeaderCollectionReusableView.m
//  RTTwoDimensionalScroll
//
//  Created by Santhosh on 21/09/16.
//  Copyright © 2016 riktam. All rights reserved.
//

#import "RTColumnHeaderCollectionReusableView.h"

@interface RTColumnHeaderCollectionReusableView()

@property (nonatomic,strong) UILabel *columnNumber;

@end

@implementation RTColumnHeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor grayColor];
        
        _columnNumber = [[UILabel alloc] initWithFrame:self.bounds];
        _columnNumber.backgroundColor = [UIColor clearColor];
        _columnNumber.layer.borderWidth = 0.5;
        _columnNumber.layer.borderColor = [UIColor whiteColor].CGColor;
        _columnNumber.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_columnNumber];
    }
    
    return self;
}

- (void)setColumnHeaderDetail:(RTColumnHeaderDetails *)columnHeaderDetail
{
    _columnHeaderDetail = columnHeaderDetail;
    _columnNumber.text = columnHeaderDetail.columnText;
}

@end
