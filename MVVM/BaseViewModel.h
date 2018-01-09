//
//  BaseViewModel.h
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/5.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseSectionModel.h"

@protocol BaseViewModelDelegate

@required

- (void)performUpdatesAnimated:(BOOL)animated completion:(IGListUpdaterCompletion)completion;

@end

@interface BaseViewModel : NSObject

@property(nonatomic, strong, readonly) NSArray<BaseSectionModel *> *sectionModels;

@property(nonatomic, strong, readonly) NSArray<BaseSectionModel *> *visibleSectionModels;

@property(nonatomic, weak) id<BaseViewModelDelegate> delegate;

@property (nonatomic, assign) BOOL isLoading;

@property (nonatomic, assign) BOOL isLoadingMore;

@property (nonatomic, assign) BOOL isRefreshing;

- (void)didBindViewController;

- (void)reload:(BOOL)animated;

//need override
- (NSArray<BaseSectionModel *> *) newSectionModels;

- (void)performUpdatesAnimated:(BOOL)animated completion:(IGListUpdaterCompletion)completion;

@end
