//
//  BaseCollectionViewController.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/5.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import "BaseViewModel.h"
#import "BaseSectionController.h"


@interface BaseCollectionViewController()<IGListAdapterDataSource, UIScrollViewDelegate, BaseViewModelDelegate, IGListBindingSectionControllerSelectionDelegate>

@property (nonatomic, assign) Boolean hadSetupViewModel;

@property (nonatomic, strong) IGListAdapter *listAdapter;

@end

@implementation BaseCollectionViewController


- (void)loadView {
    _collectionView = [self loadCollectionView];
    self.view = self.collectionView;
    
    _listAdapter = [[IGListAdapter alloc] initWithUpdater:[IGListAdapterUpdater new] viewController:self];
    _listAdapter.dataSource = self;
    _listAdapter.collectionView = self.collectionView;
    _listAdapter.scrollViewDelegate = self;
}

- (BaseViewModel *)loadViewModel {
    return nil;
}

- (UICollectionView*)loadCollectionView {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[self loadCollectionLayout]];
    collectionView.backgroundColor = [UIColor whiteColor];
    return collectionView;
}

- (UICollectionViewLayout*)loadCollectionLayout {
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return layout;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.viewModel == nil) {
        [self bindViewModel:[self loadViewModel]];
    }
}

- (NSDictionary<NSString *,Class> *)cellModel2Cell {
    return nil;
}

- (void)bindViewModel:(BaseViewModel *)viewModel {
    _viewModel = viewModel;
    _viewModel.delegate = self;
    [_viewModel didBindViewController];
}

- (nullable UIView *)emptyViewForListAdapter:(nonnull IGListAdapter *)listAdapter {
    return nil;
}

- (nonnull IGListSectionController *)listAdapter:(nonnull IGListAdapter *)listAdapter sectionControllerForObject:(nonnull id)object {
    return [[BaseSectionController alloc] initWithCellModelToCell:[self cellModel2Cell] selectionDelegate:self];
}

- (nonnull NSArray<id<IGListDiffable>> *)objectsForListAdapter:(nonnull IGListAdapter *)listAdapter {
    return _viewModel.sectionModels;
}

- (void)performUpdatesAnimated:(BOOL)animated completion:(IGListUpdaterCompletion)completion {
    [_listAdapter performUpdatesAnimated:YES completion:completion];
}

- (void)sectionController:(nonnull IGListBindingSectionController *)sectionController didSelectItemAtIndex:(NSInteger)index viewModel:(nonnull id)viewModel {
    
}

@end
