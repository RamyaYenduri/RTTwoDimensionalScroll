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
    RTCellDetails *celldetail = [[RTCellDetails alloc] init];
    celldetail.cellSize = CGSizeMake(200,100);
    NSArray *rowAry = [[NSArray alloc] initWithObjects:celldetail,celldetail,celldetail,celldetail,celldetail,celldetail,celldetail,celldetail,celldetail,celldetail,nil];
    
    NSArray *ary = [[NSArray alloc] initWithObjects:rowAry,rowAry,rowAry,rowAry,rowAry,rowAry,rowAry,rowAry,rowAry,rowAry,nil];
    
    return ary;
}

- (NSArray *)buildrowHeaderDetailsAry
{
    RTRowHeaderDetails *rowHeaderdetail = [[RTRowHeaderDetails alloc] init];
    rowHeaderdetail.rowHeaderSize = CGSizeMake(100,100);
    NSArray *ary = [[NSArray alloc] initWithObjects:rowHeaderdetail,rowHeaderdetail,rowHeaderdetail,rowHeaderdetail,rowHeaderdetail,rowHeaderdetail,rowHeaderdetail,rowHeaderdetail,rowHeaderdetail,rowHeaderdetail,nil];
    
    return ary;
}

- (NSArray *)buildcolumnHeaderDetailsAry
{
    RTColumnHeaderDetails *columnHeaderDetail = [[RTColumnHeaderDetails alloc] init];
    columnHeaderDetail.columnHeaderSize = CGSizeMake(200,50);
    
    NSArray *ary = [[NSArray alloc] initWithObjects:columnHeaderDetail,columnHeaderDetail,columnHeaderDetail,columnHeaderDetail,columnHeaderDetail,columnHeaderDetail,columnHeaderDetail,columnHeaderDetail,columnHeaderDetail,columnHeaderDetail,nil];
    
    return ary;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
