//
//  CustomCollectionViewController.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/8.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "CustomCollectionViewController.h"
#import "CustomCellModel.h"
#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewController

- (BaseViewModel *)loadViewModel {
    return [CustomViewModel new];
}

- (void)bindViewModel:(BaseViewModel *)viewModel {
    [super bindViewModel:viewModel];
    [self.viewModel update];
}

- (NSDictionary<NSString *, Class> *)cellModel2Cell {
    return @{[CustomCellModel cellIdentifier]: [CustomCollectionViewCell class]};
}


@end
