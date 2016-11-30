//
//  MyLayout.m
//  EllePlusTry
//
//  Created by natsu on 2016/10/24.
//  Copyright © 2016年 natsu. All rights reserved.
//

#import "MyLayout.h"

//static CGFloat cellheight = 200.;

@implementation MyLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置内边距
//    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
//    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:array copyItems:YES];
    
    
    for (UICollectionViewLayoutAttributes *attrs in arr) {
        
        attrs.zIndex = attrs.indexPath.item;
        
        // item距离collectionview顶部的距离
        CGFloat distance;
        // cell 高度
        CGFloat itemheight = attrs.size.height;
        if (attrs.indexPath.item >= 1) {
            distance = (attrs.indexPath.item - 1)*itemheight/self.ratio + itemheight - self.collectionView.contentOffset.y - self.collectionView.contentInset.top;
        }else {
            distance = - self.minimumLineSpacing;
        }
        
        CGFloat itemIntHeight = itemheight;
        // 防止卡顿(若是直接用itemHeight，滑动的时候会出现卡顿，闪现的效果)
//        NSInteger itemIntHeight = round(itemheight);
        
        // 控制滑动时显示出来的cell中第二个cell的特殊位移
        if (distance < itemIntHeight && distance > 0) {
            attrs.transform = CGAffineTransformMakeTranslation(0, (self.ratio - 1)*(distance - itemIntHeight));
        }
        
        // 从第2个cell开始，上滑时有叠加效果
        if (distance < - self.minimumLineSpacing) {
            attrs.transform = CGAffineTransformMakeTranslation(0, self.minimumLineSpacing);
        }
    }
    
    
    return arr;
}

// 松开手后，cell的定位
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 计算出最终显示的矩形框
    CGRect rect;
    rect.origin.x = 0;
    rect.origin.y = proposedContentOffset.y;
    rect.size = self.collectionView.frame.size;
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 加上重叠的长度
    CGFloat itemY = proposedContentOffset.y - self.minimumLineSpacing;
    
    
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta) > ABS(attrs.frame.origin.y - itemY)) {
            minDelta = attrs.frame.origin.y - itemY;
        }
    }
    
    // 修改原有的偏移量
    proposedContentOffset.y += minDelta;
    return proposedContentOffset;
}

@end
