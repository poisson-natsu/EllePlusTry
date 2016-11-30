//
//  ViewController.m
//  EllePlusTry
//
//  Created by natsu on 2016/10/24.
//  Copyright © 2016年 natsu. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
#import "MyLayout.h"

// 普通cell的高度
#define kHomeCellHeight 100.0

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, weak) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyLayout *layout = [[MyLayout alloc] init];
    layout.ratio = 3;
    layout.minimumLineSpacing = - kHomeCellHeight*(layout.ratio -1);
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(self.view.frame.size.width, kHomeCellHeight*layout.ratio);
    
    CGFloat collectionW = self.view.frame.size.width;
    CGFloat collectionH = self.view.frame.size.height - 50;
    CGFloat collectionY = 20;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, collectionY, collectionW, collectionH) collectionViewLayout:layout];
    collectionView.contentInset = UIEdgeInsetsMake(- layout.minimumLineSpacing, 0, kHomeCellHeight * layout.ratio, 0);
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor orangeColor];
    self.collectionView = collectionView;
    
    [self.view addSubview:collectionView];
    
    
    [collectionView registerClass:[MyCell class] forCellWithReuseIdentifier:@"fff"];
    [collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fff" forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Album%li.jpg", indexPath.item%10]];
    cell.tit.text = [NSString stringWithFormat:@"the no. %li", indexPath.item + 1];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
