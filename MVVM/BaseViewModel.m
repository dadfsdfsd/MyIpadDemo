//
//  BaseViewModel.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/5.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "BaseViewModel.h"


@implementation BaseViewModel {
    
    BOOL _isDataInitialized;
    
}

- (void)didBindViewController {
    if (!_isDataInitialized) {
        [self loadData];
    }
    else {
        _visibleSectionModels = @[];
        __weak __typeof(self) weakSelf = self;
        [self performUpdatesAnimated:false completion:^(BOOL finished) {
            [weakSelf refreshVisibleSectionModels];
        }];
    }
}

- (void)loadData {
    
}

- (void)markState:(ViewModelState)state completion:(void(^)(void))completion{
    if (state != _state) {
        _state = state;
        if (completion != nil) {
            completion();
        }
    }
}
 
- (void)updateWithCompletion:(void(^)(BOOL))completion {
    [self markState:ViewModelStateUpdating completion:^{
        self.state = ViewModelStateIdle;
    }];
}

- (void)refreshWithCompletion:(void(^)(BOOL))completion {
    [self markState:ViewModelStateRefreshing completion:^{
        self.state = ViewModelStateIdle;
    }];
}

- (void)loadMoreWithCompletion:(void(^)(BOOL))completion {
    [self markState:ViewModelStateLoadingMore completion:^{
        self.state = ViewModelStateIdle;
    }];
}

- (void)reload:(BOOL)aniamted {
    _sectionModels = [self newSectionModels];
    __weak __typeof(self) weakSelf = self;
    [self performUpdatesAnimated:aniamted completion:^(BOOL finished) {
        [weakSelf refreshVisibleSectionModels];
    }];
}

- (void)refreshVisibleSectionModels {
    _visibleSectionModels = _sectionModels;
}

- (NSArray<BaseSectionModel *> *)newSectionModels {
    return [NSArray<BaseSectionModel *> new];
}

- (void)performUpdatesAnimated:(BOOL)animated completion:(IGListUpdaterCompletion)completion {
    [_delegate reload:animated completion:completion];
}

@end
