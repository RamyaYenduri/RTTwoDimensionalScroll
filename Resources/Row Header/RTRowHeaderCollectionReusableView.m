//
//  RTRowHeaderCollectionReusableView.m
//  RTTwoDimensionalScroll
//
//  Created by Santhosh on 21/09/16.
//  Copyright © 2016 riktam. All rights reserved.
//

#import "RTRowHeaderCollectionReusableView.h"

@interface RTRowHeaderCollectionReusableView()

@property (nonatomic,strong) UILabel *rowHeaderLbl;

@end

@implementation RTRowHeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor greenColor];
        _rowHeaderLbl = [[UILabel alloc] initWithFrame:self.bounds];
        _rowHeaderLbl.layer.borderWidth = 0.5;
        _rowHeaderLbl.layer.borderColor = [UIColor whiteColor].CGColor;
        _rowHeaderLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_rowHeaderLbl];
    }
    
    return self;
}

- (void)setRowHeaderDetail:(RTRowHeaderDetails *)rowHeaderDetail
{
    _rowHeaderDetail = rowHeaderDetail;
    _rowHeaderLbl.text = rowHeaderDetail.rowText;
}

@end
