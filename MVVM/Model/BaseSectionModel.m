//
//  BaseSectionModel.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/5.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "BaseSectionModel.h"

@implementation BaseSectionModel

+ (instancetype)sectionModelWithCellModels:(NSArray<BaseCellModel *> *)cellModels {
    return [[self alloc] initWithCellModels:cellModels];
}

- (instancetype)initWithCellModels:(NSArray<BaseCellModel *> *)cellModels {
    if (self = [super init]) {
        _cellModels = cellModels;
    }
    return self;
}

- (BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object {
    return object.diffIdentifier == self.diffIdentifier;
}

- (id<NSObject>)diffIdentifier {
    if (_diffIdentifier) {
        return _diffIdentifier;
    }
    return self;
}

@end
