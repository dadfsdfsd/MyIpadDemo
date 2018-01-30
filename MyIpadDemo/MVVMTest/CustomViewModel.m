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

@interface CustomViewModel()

@property (nonatomic, assign) NSInteger itemCount;

@property (nonatomic, assign) CGFloat insetTop;

@property (nonatomic, assign) BOOL reverse;

@property (nonatomic, strong) NSMutableArray<CustomData *> *itemDatas;

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
    _insetTop = 10;
    _itemDatas = [NSMutableArray new];
    [self.delegate setNeedsUpdate];
}

- (void)updateWithCompletion:(void (^)(BOOL))completion {
    [self markState:ViewModelStateUpdating completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            self.state = ViewModelStateIdle;
            NSUInteger index = _itemDatas.count;
            for (NSUInteger i = index; i < index + 20; i++) {
                CustomData *data = [CustomData new];
                data.index = i;
                [_itemDatas addObject:data];
            }
            [self reload:false];
        });
        [self reload:false];
    }];
}

- (void)refreshWithCompletion:(void (^)(BOOL))completion {
    [self markState:ViewModelStateRefreshing completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            self.state = ViewModelStateIdle;
            [_itemDatas removeAllObjects];
            CustomData *data = [CustomData new];
            data.index = _itemDatas.count;
            [_itemDatas addObject:data];
            [self reload:false];
        });
    }];
}

- (void)loadMoreWithCompletion:(void (^)(BOOL))completion {
    [self markState:ViewModelStateLoadingMore completion:^{
        dispatch_after(2, dispatch_get_main_queue(), ^{
            self.state = ViewModelStateIdle;
            NSUInteger index = _itemDatas.count;
            for (NSUInteger i = index; i < index + 20; i++) {
                CustomData *data = [CustomData new];
                data.index = i;
                [_itemDatas addObject:data];
            }
            [self reload:false];
        });
    }];
}

- (NSArray<BaseSectionModel *> *)newSectionModels {
    NSMutableArray<BaseCellModel *> *cells = [NSMutableArray<BaseCellModel *> new];
    [_itemDatas enumerateObjectsUsingBlock:^(CustomData * _Nonnull data, NSUInteger idx, BOOL * _Nonnull stop) {
        CustomCellModel *cell = [[CustomCellModel alloc] initWithData:data];
        cell.backgroundColor = [UIColor greenColor];
        if (idx == _itemDatas.count - 2) {
            cell.backgroundColor = [UIColor redColor];
        }
        [cells addObject: cell];
    }];
 
    BaseSectionModel *firstSection = [BaseSectionModel sectionModelWithCellModels:cells];
    firstSection.minimumInteritemSpacing = 20;
    firstSection.minimumLineSpacing = 20;
    firstSection.inset = UIEdgeInsetsMake(_insetTop, 10, _insetTop, 10);
    firstSection.diffIdentifier = @"1";
    
    if (self.state == ViewModelStateUpdating) {
        CustomLoadingCellModel *loadingCell = [CustomLoadingCellModel new];
        firstSection.headerCell = loadingCell;
    }
    
//    NSMutableArray<BaseCellModel *> *cells2 = [NSMutableArray<BaseCellModel *> new];
//    for (NSInteger i = 0; i < _itemCount - 1; i ++) {
//        CustomData *data = [CustomData new];
//        data.index = i;
//        CustomCellModel *cell = [[CustomCellModel alloc] initWithData:data];
//        cell.backgroundColor = [UIColor redColor];
//        [cells2 addObject: cell];
//    }
//
//    if (_secondSectionTag == nil) {
//        _secondSectionTag = @"2";
//    }
//
//    BaseSectionModel *secondSection = [BaseSectionModel sectionModelWithCellModels:cells2];
//    secondSection.minimumInteritemSpacing = 20;
//    secondSection.minimumLineSpacing = 20;
//    secondSection.inset = UIEdgeInsetsMake(_insetTop, 10, _insetTop, 10);
//    secondSection.diffIdentifier = _secondSectionTag;
    
    if (!_reverse) {
        return @[firstSection];
    }
    else {
        return @[firstSection];
    }
}

- (void)test {
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号被销毁");
        }];
    }];
    [siganl subscribeNext:^(id x) {
        NSLog(@"接收到数据:%@",x);
    }];
    
    NSArray<NSNumber *> *array = @[@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8)];
    
    NSArray *newArray = [array.rac_sequence map:^id _Nullable(NSNumber*  _Nullable value) {
        return [NSNumber numberWithInt:value.integerValue];
    }];
    
    NSLog(@"%@", newArray);
}

- (void)testTuple {
    RACTuple *tuple = RACTuplePack(@"123",@1);
    RACTupleUnpack(NSString *str,NSNumber *num) = tuple;
    
    
}


@end
