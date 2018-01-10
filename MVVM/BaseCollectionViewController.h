//
//  BaseCollectionViewController.h
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/5.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IGListKit/IGListKit.h>
#import "BaseViewModel.h"
#import <KVOController/KVOController.h>

@interface BaseCollectionViewController<__covariant ViewModelType: BaseViewModel *> : UIViewController

@property (nonatomic, strong, readonly) ViewModelType viewModel;

@property (nonatomic, strong, readonly) UICollectionView *collectionView;

@property (nonatomic, assign, readonly) BOOL isAppearing;

- (UICollectionViewLayout *)loadCollectionLayout;

- (UICollectionView *)loadCollectionView;

- (void)bindViewModel:(ViewModelType)viewModel;

//need override
- (ViewModelType)loadViewModel;

- (BOOL)isRefreshEnabled;

- (BOOL)isLoadMoreEnabled;

//need override
- (NSDictionary<NSString *, Class> *) cellModel2Cell;

@end
