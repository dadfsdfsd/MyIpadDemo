//
//  BaseSectionModel.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/5.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "BaseSectionModel.h"

@implementation BaseSectionModel

+ (instancetype)sectionModelWithCellModels:(NSArray<id<BaseCellModel>> *)cellModels {
    return [[self alloc] initWithCellModels:cellModels];
}

- (instancetype)initWithCellModels:(NSArray<id<BaseCellModel>> *)cellModels {
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
        BOOL(^isHeaderCellEqual)(void) = ^(void) {
            return (BOOL)([sectionModel.headerCell isEqualToDiffableObject:self.headerCell] || (sectionModel.headerCell == nil && self.headerCell == nil));
        };
        
        BOOL(^isFooterCellEqual)(void) = ^(void) {
            return (BOOL)([sectionModel.footerCell isEqualToDiffableObject:self.footerCell] || (sectionModel.footerCell == nil && self.footerCell == nil));
        };
 
        BOOL(^isCellsEqual)(void) = ^(void) {
            BOOL result = sectionModel.cellModels.count == self.cellModels.count;
            if (result) {
                for (NSInteger i = 0; i < self.cellModels.count; i++) {
                    if (![self.cellModels[i] isEqualToDiffableObject:sectionModel.cellModels[i]]) {
                        result = false;
                        break;
                    }
                }
            }
            return result;
        };
        
        return isHeaderCellEqual() && isFooterCellEqual() && isCellsEqual();
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
