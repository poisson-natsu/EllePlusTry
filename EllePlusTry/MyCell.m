//
//  MyCell.m
//  EllePlusTry
//
//  Created by natsu on 2016/10/24.
//  Copyright © 2016年 natsu. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.imgView];
        
        self.tit = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height*0.5)];
        self.tit.textColor = [UIColor whiteColor];
        self.tit.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.tit];
    }
    return self;
}
@end
