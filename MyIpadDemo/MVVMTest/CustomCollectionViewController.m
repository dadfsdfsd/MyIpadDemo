//
//  CustomCollectionViewController.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/8.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "CustomCollectionViewController.h"
#import "CustomCellModel.h"
#import "CustomLoadingCellModel.h"
#import "CustomCollectionViewCell.h"
#import "CustomLoadingCollectionViewCell.h"
#import "UIColor+EX.h"
 

@implementation CustomCollectionViewController

- (BaseViewModel *)loadViewModel {
    return [CustomViewModel new];
}

- (void)bindViewModel:(BaseViewModel *)viewModel {
    [super bindViewModel:viewModel];
}

- (NSDictionary<NSString *, Class> *)cellModel2Cell {
    return @{[CustomCellModel cellIdentifier]: [CustomCollectionViewCell class],
             [CustomLoadingCellModel cellIdentifier]: [CustomLoadingCollectionViewCell class]
             };
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
        cellModel.backgroundColor = [UIColor randomColor];
        
        CustomCellModel *cellModel2 =  (CustomCellModel *)[[self viewModel] cellModelAtIndexPath:[NSIndexPath indexPathForRow:index inSection:sectionController.section]];
        
        if (cellModel != cellModel2) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"error" message:@"cellModel error" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:true completion:nil];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *moveButton = [[UIBarButtonItem alloc] initWithTitle:@"move" style:UIBarButtonItemStyleDone target:self action:@selector(doMove)];
    UIBarButtonItem *insertAndDeleteButton = [[UIBarButtonItem alloc] initWithTitle:@"doInsert&Delete" style:UIBarButtonItemStyleDone target:self action:@selector(doInsertAndDelete)];
    UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithTitle:@"reload" style:UIBarButtonItemStyleDone target:self action:@selector(doReload)];
    
    self.navigationItem.rightBarButtonItems = @[moveButton, insertAndDeleteButton, reloadButton];
}

- (void)doMove {
    CustomViewModel *viewModel = [self viewModel];
    [viewModel doMove];
}

- (void)doInsertAndDelete {
    CustomViewModel *viewModel = [self viewModel];
    [viewModel doInsetAndDelete];
}

- (void)doReload {
    CustomViewModel *viewModel = [self viewModel];
    [viewModel reload:true];
}

@end
