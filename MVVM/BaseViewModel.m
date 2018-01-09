//
//  BaseViewModel.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/5.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "BaseViewModel.h"


@implementation BaseViewModel {
    
    BOOL isDataInitialized;
    
}

- (void)didBindViewController {
    if (!isDataInitialized) {
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
    _isLoading = true;
    [self update];
}

- (void)update {
    
}

- (void)refresh {
    
}

- (void)loadMore {
    
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
    [_delegate performUpdatesAnimated:animated completion:completion];
}

@end
