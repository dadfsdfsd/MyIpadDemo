//
//  CustomViewModel.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/8.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "CustomViewModel.h"
#import "BaseDataCellModel.h"
#import "BaseSectionModel.h"
#import "CustomCellModel.h"

@interface CustomViewModel()

@property (nonatomic, assign) NSInteger itemCount;

@property (nonatomic, assign) CGFloat insetTop;

@property (nonatomic, strong) NSString *firstSectionTag;

@property (nonatomic, strong) NSString *secondSectionTag;

@property (nonatomic, strong) BaseSectionModel *firstSectionModel;

@property (nonatomic, assign) BOOL reverse;

@end


@implementation CustomViewModel

- (void)intializeTimer {
    _insetTop = 10;
    [NSTimer scheduledTimerWithTimeInterval:2 repeats:false block:^(NSTimer * _Nonnull timer) {
        self.state = ViewModelStateIdle;
        if (self.itemCount < 4) {
            self.itemCount += 3;
            [self reload:true];
        }
        else {
//            if (self.insetTop < 50) {
//                self.insetTop += 10;
//                [self reload:true];
//            }
//            else {
                _reverse = !_reverse;
                [self reload:true];
//            }
        }
    }];
}

- (void)loadData {
    [self.delegate setNeedsUpdate];
}

- (void)updateWithCompletion:(void (^)(BOOL))completion {
    [self markState:ViewModelStateUpdating completion:^{
        [self reload:false];
        [self intializeTimer];
    }];
}

- (void)refreshWithCompletion:(void (^)(BOOL))completion {
    [self markState:ViewModelStateRefreshing completion:^{
        dispatch_after(2, dispatch_get_main_queue(), ^{
            self.state = ViewModelStateIdle;
            self.itemCount = 4;
            [self reload:false];
        });
    }];
}

- (void)loadMoreWithCompletion:(void (^)(BOOL))completion {
    [self markState:ViewModelStateLoadingMore completion:^{
        dispatch_after(2, dispatch_get_main_queue(), ^{
            self.state = ViewModelStateIdle;
            self.itemCount += 4;
            [self reload:false];
        });
    }];
}

- (NSArray<BaseSectionModel *> *)newSectionModels {
    NSMutableArray<BaseCellModel *> *cells = [NSMutableArray<BaseCellModel *> new];
    for (NSInteger i = 0; i < _itemCount; i ++) {
        CustomCellModel *cell = [[CustomCellModel alloc] initWithData:[NSNumber numberWithInteger:i]];
        cell.backgroundColor = [UIColor greenColor];
        [cells addObject: cell];
    }
    
    if (_firstSectionTag == nil) {
        _firstSectionTag = @"1";
    }
    
    BaseSectionModel *firstSection = [BaseSectionModel sectionModelWithCellModels:cells];
    firstSection.minimumInteritemSpacing = 20;
    firstSection.minimumLineSpacing = 20;
    firstSection.inset = UIEdgeInsetsMake(_insetTop, 10, _insetTop, 10);
    firstSection.diffIdentifier = _firstSectionTag;
    
    if (self.state == ViewModelStateUpdating) {
        CustomCellModel *cell = [[CustomCellModel alloc] initWithData:[NSNumber numberWithInteger:999]];
        cell.backgroundColor = [UIColor blueColor];
        firstSection.headerCell = cell;
    }
    _firstSectionModel = firstSection;
    
    NSMutableArray<BaseCellModel *> *cells2 = [NSMutableArray<BaseCellModel *> new];
    for (NSInteger i = 0; i < _itemCount - 1; i ++) {
        CustomCellModel *cell = [[CustomCellModel alloc] initWithData:[NSNumber numberWithInteger:i]];
        cell.backgroundColor = [UIColor redColor];
        [cells2 addObject: cell];
    }
    
    if (_secondSectionTag == nil) {
        _secondSectionTag = @"2";
    }
    
    BaseSectionModel *secondSection = [BaseSectionModel sectionModelWithCellModels:cells2];
    secondSection.minimumInteritemSpacing = 20;
    secondSection.minimumLineSpacing = 20;
    secondSection.inset = UIEdgeInsetsMake(_insetTop, 10, _insetTop, 10);
    secondSection.diffIdentifier = _secondSectionTag;
    
    if (!_reverse) {
        return @[firstSection, secondSection];
    }
    else {
        return @[secondSection, firstSection];
    }
    
}

@end
