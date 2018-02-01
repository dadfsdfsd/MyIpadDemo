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
#import <ReactiveObjC.h>
#import "CustomData.h"
#import "CustomLoadingCellModel.h"
#import "NSMutableArray+Move.h"

@interface CustomViewModel()

@property (nonatomic, assign) NSInteger itemCount;

@property (nonatomic, assign) CGFloat insetTop;

@property (nonatomic, assign) BOOL reverse;

@property (nonatomic, strong) NSMutableArray<CustomSectionData *> *itemDatas;

@end


@implementation CustomViewModel

- (void)loadData {
    _insetTop = 30;
    _itemDatas = [NSMutableArray new];
    [self.delegate setNeedsUpdate];
}

- (void)updateWithCompletion:(void (^)(BOOL))completion {
    [self markState:ViewModelStateUpdating completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            self.state = ViewModelStateIdle;
            NSUInteger index = _itemDatas.count;
            for (NSUInteger i = index; i < index + 20; i++) {
                NSInteger numberOfItems = random()%10;
                NSMutableArray *items = [NSMutableArray new];
                for (NSInteger i = numberOfItems; i < numberOfItems; i ++) {
                    CustomData *subData = [CustomData new];
                    subData.index = i;
                    [items addObject:subData];
                }
                CustomSectionData *sectionData = [CustomSectionData new];
                sectionData.items = items;
                [_itemDatas addObject:sectionData];
            }
            [self reload:false];
        });
        [self reload:false];
    }];
}

- (void)refreshWithCompletion:(void (^)(BOOL))completion {
    [self markState:ViewModelStateRefreshing completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            self.state = ViewModelStateIdle;
            [_itemDatas removeAllObjects];
//            CustomData *data = [CustomData new];
//            data.index = _itemDatas.count;
//            [_itemDatas addObject:data];
            [self reload:false];
        });
    }];
}

- (void)loadMoreWithCompletion:(void (^)(BOOL))completion {
    [self markState:ViewModelStateLoadingMore completion:^{
        dispatch_after(2, dispatch_get_main_queue(), ^{
            self.state = ViewModelStateIdle;
 
            NSInteger numberOfItems = random()%10;
            NSMutableArray *items = [NSMutableArray new];
            for (NSInteger i = 0; i < numberOfItems; i ++) {
                CustomData *subData = [CustomData new];
                subData.index = i;
                [items addObject:subData];
            }
            CustomSectionData *sectionData = [CustomSectionData new];
            _itemDatas.lastObject.items = items;
            
            for (NSUInteger i = 0; i < 1; i++) {
                NSInteger numberOfItems = random()%10;
                NSMutableArray *items = [NSMutableArray new];
                for (NSInteger i = 0; i < numberOfItems; i ++) {
                    CustomData *subData = [CustomData new];
                    subData.index = i;
                    [items addObject:subData];
                }
                CustomSectionData *sectionData = [CustomSectionData new];
                sectionData.items = items;
                [_itemDatas addObject:sectionData];
            }
            
          
            
            
            [self reload:false];
        });
    }];
}

- (NSArray<BaseSectionModel *> *)newSectionModels {
    
    NSMutableArray<BaseSectionModel *> *sectionModels = [NSMutableArray new];
    
    if (self.state == ViewModelStateUpdating) {
        CustomLoadingCellModel *loadingCell = [CustomLoadingCellModel new];
        BaseSectionModel *section = [BaseSectionModel sectionModelWithCellModels:@[]];
        section.headerCell = loadingCell;
        [sectionModels addObject:section];
    }
    else {
        for (CustomSectionData *data in _itemDatas) {
            NSMutableArray<BaseCellModel *> *cells = [NSMutableArray<BaseCellModel *> new];
            for (CustomData *subData in data.items) {
                CustomCellModel *cell = [[CustomCellModel alloc] initWithData:subData];
                cell.backgroundColor = [UIColor greenColor];
                [cells addObject: cell];
            }
            
            if (cells.count > 0) {
                BaseSectionModel *section = [BaseSectionModel sectionModelWithCellModels:cells];
                section.minimumInteritemSpacing = 20;
                section.minimumLineSpacing = 20;
                section.inset = UIEdgeInsetsMake(_insetTop, 10, _insetTop, 10);
                section.diffIdentifier = data;
                [sectionModels addObject:section];
            }
        }
    }
    
    return sectionModels;
}

- (void)doMove {
    
    [_itemDatas enumerateObjectsUsingBlock:^(CustomSectionData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *tmp  = [obj.items mutableCopy];
        if (obj.items.count > 5) {
            [tmp moveObjectAtIndex:4 toIndex:0];
            [tmp moveObjectAtIndex:3 toIndex:2];
            [tmp moveObjectAtIndex:4 toIndex:3];
            [tmp removeObjectAtIndex:0];
            
            CustomData *data = [CustomData new];
            data.index = 999;
            [tmp insertObject:data atIndex:3];
            
            [tmp removeObjectAtIndex:0];
            
            CustomData *data2 = [CustomData new];
            data2.index = 9999;
            [tmp insertObject:data2 atIndex:2];
            
            [tmp moveObjectAtIndex:3 toIndex:2];
            [tmp moveObjectAtIndex:4 toIndex:3];
            
        }

        obj.items= [tmp copy];
    }];
    [self reload:true];
}

@end
