//
//  MyLayout.h
//  EllePlusTry
//
//  Created by natsu on 2016/10/24.
//  Copyright © 2016年 natsu. All rights reserved.
//  实现自动滑动以补齐item--最终

#import <UIKit/UIKit.h>

@interface MyLayout : UICollectionViewFlowLayout

// 大cell为普通cell的高度的倍数
@property(nonatomic, assign) NSInteger ratio;

@end
