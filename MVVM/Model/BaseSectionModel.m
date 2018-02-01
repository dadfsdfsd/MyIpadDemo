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
    if (object == self) {
        return true;
    }
    BaseSectionModel *sectionModel = (BaseSectionModel *)object;
    if ([sectionModel isKindOfClass:[BaseSectionModel class]]) {
        BOOL a = [[sectionModel.headerCell.class cellIdentifier] isEqualToString:[self.headerCell.class cellIdentifier]] || (sectionModel.headerCell == nil && self.headerCell == nil);
        BOOL b = ([[sectionModel.footerCell.class cellIdentifier] isEqualToString:[self.footerCell.class cellIdentifier]]|| (sectionModel.footerCell == nil && self.footerCell == nil));
        return sectionModel.diffIdentifier == self.diffIdentifier && b && a;
    }
    return false;
}

- (id<NSObject>)diffIdentifier {
    if (_diffIdentifier) {
        return _diffIdentifier;
    }
    return self;
}

- (void)didExitWorkingRange {
    
}

- (void)willEnterWorkingRange {
    
}

@end
