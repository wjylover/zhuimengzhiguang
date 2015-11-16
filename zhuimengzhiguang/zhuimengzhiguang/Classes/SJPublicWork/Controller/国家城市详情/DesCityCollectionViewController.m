//
//  DesCityCollectionViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "DesCityCollectionViewController.h"
#import "DesCityRequestHandle.h"
#import "DesCityCell.h"


@interface DesCityCollectionViewController ()

@property (nonatomic,strong) NSArray *array;

@end

@implementation DesCityCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    //注意  注意  注意: 重要的事情要说三遍  --->>> 设置的是collectionView的背景,不是self.view   要不然   界面会一直是黑色的
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //布局
    [self layoutCollectionView];
    //网络请求
    [self getValuesWithRequest];
}

//布局
-(void)layoutCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置item大小
    flowLayout.itemSize = CGSizeMake(self.collectionView.bounds.size.width/2 - 50, 130);
    //设置间距
    flowLayout.sectionInset = UIEdgeInsetsMake(30, 50, 10, 30);
    self.collectionView.collectionViewLayout = flowLayout;
    //设置滚动条是否显示
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"DesCityCell" bundle:nil] forCellWithReuseIdentifier:@"desCityCell"];
}

//网络请求
-(void)getValuesWithRequest
{
    [[DesCityRequestHandle shareDesCityRequestHandle]requestHandleDesCityRequestHandle];
    [DesCityRequestHandle shareDesCityRequestHandle].result = ^(){
        //将对象数组中的数据给array
        self.array = [NSArray arrayWithArray:[DesCityRequestHandle shareDesCityRequestHandle].dataArray];
        //刷新
        [self.collectionView reloadData];
    };
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    DesCityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"desCityCell" forIndexPath:indexPath];
    
    DesCityModel *model = [DesCityModel new];
    model = self.array[indexPath.item];
    cell.model = model;
    
    
    return cell;
}

//设置item的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.bounds.size.width/2 - 60, 180);
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
