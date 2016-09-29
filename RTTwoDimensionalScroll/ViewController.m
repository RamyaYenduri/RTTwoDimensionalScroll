//
//  ViewController.m
//  RTTwoDimensionalScroll
//
//  Created by Santhosh on 30/08/16.
//  Copyright © 2016 riktam. All rights reserved.
//

#import "ViewController.h"
#import "RTCollectionView.h"
#import "RTDataSource.h"

#import "RTCellDetails.h"
#import "RTColumnHeaderDetails.h"
#import "RTRowHeaderDetails.h"

@interface ViewController ()<RTCollectionViewDelegate>
{
    RTDataSource *collectionViewDataSource;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    collectionViewDataSource = [[RTDataSource alloc] init];
    collectionViewDataSource.collectionViewData = [self buildTheDataForTheCollectionView];
    
    RTCollectionView *collectionView = [[RTCollectionView alloc] initWithFrame:self.view.bounds];
    collectionView.rtDelegate = self;
    collectionView.rtDataSource = collectionViewDataSource;
    
    [self.view addSubview:collectionView];
   
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (RTCollectionViewData *)buildTheDataForTheCollectionView
{
    RTCollectionViewData *data = [[RTCollectionViewData alloc] init];
    
    data.noOfRows = 10;
    data.noOfColumns = 10;
    
    data.cellDetailsArray = [self buildCellDetailsAry];
    data.rowHeaderDetailsArray = [self buildrowHeaderDetailsAry];
    data.columnHeaderDetailsArray = [self buildcolumnHeaderDetailsAry];
    
    return data;
}

- (NSArray *)buildCellDetailsAry
{
    NSMutableArray *ary = [[NSMutableArray alloc] init];
    
    for (int i = 1 ; i <= 10 ; i++)
    {
        NSMutableArray *rowAry = [[NSMutableArray alloc] init];
        
        for (int j = 1; j <= 5 ; j++)
        {
            RTCellDetails *celldetail = [[RTCellDetails alloc] init];
            celldetail.cellSize = CGSizeMake(400,100);
            celldetail.cellText = [NSString stringWithFormat:@"(%i,%i)",i,j];
            [rowAry addObject:celldetail];
        }
        [ary addObject:rowAry];
    }
    
    return ary;
}

- (NSArray *)buildrowHeaderDetailsAry
{
    NSMutableArray *ary = [[NSMutableArray alloc] init];

    for (int i = 1 ; i <= 10 ; i++ )
    {
        RTRowHeaderDetails *rowHeaderdetail = [[RTRowHeaderDetails alloc] init];
        rowHeaderdetail.rowHeaderSize = CGSizeMake(100,100);
        rowHeaderdetail.rowText = [NSString stringWithFormat:@"%i",i];
        
        [ary addObject:rowHeaderdetail];
    }
    
    return ary;
}

- (NSArray *)buildcolumnHeaderDetailsAry
{
    NSMutableArray *ary = [[NSMutableArray alloc] init];
    
    for (int i = 1 ; i <= 10 ; i++ )
    {
        RTColumnHeaderDetails *columnHeaderDetail = [[RTColumnHeaderDetails alloc] init];
        columnHeaderDetail.columnHeaderSize = CGSizeMake(200,50);
        columnHeaderDetail.columnText = [NSString stringWithFormat:@"%i",i];
        
        [ary addObject:columnHeaderDetail];
    }
    
    return ary;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
