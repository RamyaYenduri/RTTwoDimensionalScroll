//
//  RTCollectionViewCell.m
//  RTTwoDimensionalScroll
//
//  Created by Santhosh on 21/09/16.
//  Copyright © 2016 riktam. All rights reserved.
//

#import "RTCollectionViewCell.h"

@interface RTCollectionViewCell()

@property (nonatomic,strong) UILabel *cellLbl;

@end

@implementation RTCollectionViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor redColor];
        
        _cellLbl = [[UILabel alloc] initWithFrame:self.bounds];
        _cellLbl.backgroundColor = [UIColor clearColor];
        _cellLbl.layer.borderWidth = 0.5;
        _cellLbl.layer.borderColor = [UIColor whiteColor].CGColor;
        _cellLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_cellLbl];
    }
    
    return self;
}

- (void)setCellDetail:(RTCellDetails *)cellDetail
{
    _cellDetail = cellDetail;
    _cellLbl.text = cellDetail.cellText;
}

@end
