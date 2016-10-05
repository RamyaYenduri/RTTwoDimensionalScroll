# RTTwoDimensionalScroll
Two dimensional scroll using ui collection view

![output_csfgsq](https://cloud.githubusercontent.com/assets/15356760/19109295/4ade02ea-8b12-11e6-87c7-02fb7cdf074c.gif)

#### Manual
You can include the files to your project from the Resources folder of the library

### Importing

```obj-c
#import "RTCollectionView.h"
#import "RTDataSource.h"

#import "RTCellDetails.h"
#import "RTColumnHeaderDetails.h"
#import "RTRowHeaderDetails.h" 

```

#### Library Usage

You can create a two dimmensional scroll using the RTCollection view

#### Initialisation

data source

```obj-c 
collectionViewDataSource = [[RTDataSource alloc] init];
collectionViewDataSource.collectionViewData = [self buildTheDataForTheCollectionView];
// buildTheDataForTheCollectionView should return RTCOLLECTION VIEW DATA object 
```
Collection view declaration

```obj-c    
RTCollectionView *collectionView = [[RTCollectionView alloc] initWithFrame:CGRectMake(0,20,self.view.frame.size.width,self.view.frame.size.height - 20)];
collectionView.rtDelegate = self;
collectionView.rtDataSource = collectionViewDataSource;
    
[self.view addSubview:collectionView];
```

#### Variables and its importance

```obj-c
RTCollectionViewData *data = [[RTCollectionViewData alloc] init];
    
data.noOfRows = 8; // represents total number of rows.
data.noOfColumns = 5; // represents total number of columns.
    
data.cellDetailsArray = [self buildCellDetailsAry];
data.rowHeaderDetailsArray = [self buildrowHeaderDetailsAry]; // array count represents the total number of row headers.
// buildrowHeaderDetailsAry funtion should return array of RTRowHeaderDetails object
data.columnHeaderDetailsArray = [self buildcolumnHeaderDetailsAry];// array count represents the total number of column headers.
// buildcolumnHeaderDetailsAry funtion should return array of RTColumnHeaderDetails object
```
#### Delegate Handler (RTCollectionViewDelegate)

To notify when the user taps on the cell 

```obj-c
- (void)collectionView:(RTCollectionView *)collectionView didSelectItemAtIndex:(struct RTRowColumnIndex)index;
```

#### UI 

for changing the view for cell or row header or column header change the code for the below methods in RTDataSource

```obj-c
- (RTCollectionViewCell *)collectionView:(RTCollectionView *)collectionView cellForRTRowColumnIndex:(struct RTRowColumnIndex)index
- (RTColumnHeaderCollectionReusableView *)collectionView:(RTCollectionView *)collectionView viewForColumnHeaderAtIndex:(NSInteger)columnIndex
- (RTRowHeaderCollectionReusableView *)collectionView:(RTCollectionView *)collectionView viewForRowHeaderAtIndex:(NSInteger)columnIndex
```
