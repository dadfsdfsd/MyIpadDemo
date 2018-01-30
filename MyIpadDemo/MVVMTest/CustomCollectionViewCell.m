//
//  CustomCollectionViewCell.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/8.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "CustomCollectionViewCell.h"
#import "CustomCellModel.h"

@interface CustomCollectionViewCell()

@property (nonatomic, strong) UILabel *titleLabe;

@end

@implementation CustomCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    _titleLabe = ({
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label;
    });
    
    [self.contentView addSubview:_titleLabe];
    
//    self.backgroundColor = [UIColor redColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabe.frame = self.contentView.bounds;
}

- (void)bindCellModel:(id)cellModel {
    CustomCellModel *customCellModel = (CustomCellModel *)cellModel;
    if ([customCellModel isKindOfClass:[CustomCellModel class]]) {
        _titleLabe.text = [NSString stringWithFormat:@"%ld", (long)customCellModel.data.index];
        self.tintColor = [UIColor blackColor];
    }
    
}

@end
