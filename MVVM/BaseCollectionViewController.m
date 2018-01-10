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
#import <MJRefresh/MJRefresh.h>


@interface BaseCollectionViewController()<IGListAdapterDataSource, UIScrollViewDelegate, BaseViewModelDelegate, IGListBindingSectionControllerSelectionDelegate>

@property (nonatomic, strong) IGListAdapter *listAdapter;

@property (nonatomic, assign) BOOL needsUpdate;

@property (nonatomic, assign) BOOL needsRefresh;

@end

@implementation BaseCollectionViewController


- (void)loadView {
    _collectionView = [self loadCollectionView];
    self.view = self.collectionView;
    
    [self checkLoadMoreEnabled];
    [self checkRefreshHeaderEnabled];
    
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

- (BOOL)isRefreshEnabled {
    return false;
}

- (BOOL)isLoadMoreEnabled {
    return false;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.viewModel == nil) {
        [self bindViewModel:[self loadViewModel]];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _isAppearing = true;
    
    // Priority: Refresh > Update > Reload
    if (_needsRefresh) {
        _needsUpdate = false;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self beginRefreshing];
        });
    }
    else if (_needsUpdate) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self beginUpdating];
        });
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    _isAppearing = false;
}

- (NSDictionary<NSString *,Class> *)cellModel2Cell {
    return nil;
}

- (void)bindViewModel:(BaseViewModel *)viewModel {
    if (_viewModel == viewModel) {
        return;
    }
    if (_viewModel) {
        [_viewModel removeObserver:self forKeyPath:@"state"];
    }
    if (viewModel) {
        [viewModel addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    _viewModel = viewModel;
    _viewModel.delegate = self;
    [_viewModel didBindViewController];
}

- (void)dealloc {
    [_viewModel removeObserver:self forKeyPath:@"state"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"state"]) {
        switch (_viewModel.state) {
            case ViewModelStateIdle:
                [self endLoadingMore];
                [self endRefreshing];
                break;
            case ViewModelStateError:
                [self endLoadingMore];
                [self endRefreshing];
                break;
            case ViewModelStateUpdating:
                [self endRefreshing];
                break;
            case ViewModelStateRefreshing:
                [self endLoadingMore];
                break;
            case ViewModelStateLoadingMore:
                [self endRefreshing];
                break;
            default:
                break;
        }
    }
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

- (void)checkRefreshHeaderEnabled{
    if ([self isRefreshEnabled]) {
        if (_collectionView.mj_header == nil) {
            __weak __typeof(self) weakSelf = self;
            _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [weakSelf.viewModel refreshWithCompletion:nil];
            }];
        }
    }
    else {
        _collectionView.mj_header = nil;
    }
}

- (void)checkLoadMoreEnabled {
    if ([self isLoadMoreEnabled]) {
        if (_collectionView.mj_footer == nil) {
            __weak __typeof(self) weakSelf = self;
            _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [weakSelf.viewModel loadMoreWithCompletion:nil];
            }];
        }
    }
    else {
        _collectionView.mj_footer = nil;
    }
}

- (void)endLoadingMore {
    if ([_collectionView.mj_footer isRefreshing]) {
        [_collectionView.mj_footer endRefreshing];
    }
}

- (void)endRefreshing {
    if ([_collectionView.mj_header isRefreshing]) {
        [_collectionView.mj_header endRefreshing];
    }
}

- (void)reload:(BOOL)animated completion:(IGListUpdaterCompletion)completion {
    [self checkLoadMoreEnabled];
    [self checkRefreshHeaderEnabled];
    [_listAdapter performUpdatesAnimated:animated completion:completion];
}

- (void)setNeedsRefresh {
    if (_isAppearing) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self beginRefreshing];
        });
    }
    else {
        _needsRefresh = true;
    }
}

- (void)beginRefreshing {
    _needsRefresh = false;
    [_viewModel refreshWithCompletion:nil];
}

- (void)beginUpdating {
    _needsUpdate = false;
    [_viewModel updateWithCompletion:nil];
}

- (void)setNeedsUpdate {
    if (_isAppearing) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self beginUpdating];
        });
    }
    else {
        _needsUpdate = true;
    }
}

- (void)sectionController:(nonnull IGListBindingSectionController *)sectionController didSelectItemAtIndex:(NSInteger)index viewModel:(nonnull id)viewModel {
}


@end
