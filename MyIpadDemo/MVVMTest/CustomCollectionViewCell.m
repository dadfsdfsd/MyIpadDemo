//
//  CustomCollectionViewCell.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/8.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "CustomCollectionViewCell.h"
#import "CustomCellModel.h"
#import "NSObject+ObservationManager.h"

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
    [[self observationManager] unobserveAll];
    
    CustomCellModel *customCellModel = (CustomCellModel *)cellModel;
    if ([customCellModel isKindOfClass:[CustomCellModel class]]) {
        _titleLabe.text = [NSString stringWithFormat:@"%ld", (long)customCellModel.data.index];
        __weak __typeof(self) weakSelf = self;
        [[self observationManager] observe:[[DynamicObservable<UIColor *> alloc] initWithTarget:customCellModel keyPath:@"backgroundColor" shouldRetainTarget:true] withEventHandler:^(ValueChange<UIColor *> *change) {
            UIColor *newColor = change.nValue;
            weakSelf.backgroundColor = newColor;
        }];
        self.backgroundColor = customCellModel.backgroundColor;
    }
}

@end
