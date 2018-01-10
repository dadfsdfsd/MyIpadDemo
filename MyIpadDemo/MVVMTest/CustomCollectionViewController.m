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
}

- (NSDictionary<NSString *, Class> *)cellModel2Cell {
    return @{[CustomCellModel cellIdentifier]: [CustomCollectionViewCell class]};
}

- (BOOL)isRefreshEnabled {
    return true;
}

- (BOOL)isLoadMoreEnabled {
    return true;
}

- (void)sectionController:(nonnull IGListBindingSectionController *)sectionController didSelectItemAtIndex:(NSInteger)index viewModel:(nonnull id)viewModel {
    if ([viewModel isKindOfClass:[CustomCellModel class]]) {
        CustomCellModel *cellModel = (CustomCellModel *)viewModel;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"点击了一个Cell" message:cellModel.data.stringValue preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alertController dismissViewControllerAnimated:true completion:nil];
        }]];
        [self presentViewController:alertController animated:true completion:nil];
    }
}


@end
