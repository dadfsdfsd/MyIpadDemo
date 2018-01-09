//
//  BaseCellModel.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/5.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "BaseCellModel.h"

@interface BaseCellModel ()

@property (nonatomic, assign) BOOL hasCalculatedSize;

@end

@implementation BaseCellModel

+ (NSString *)cellIdentifier {
    return NSStringFromClass(self);
}

- (CGSize)expectedSizeForContainerSize:(CGSize)containerSize {
    if (_hasCalculatedSize) {
        return _cachedSize;
    }
    _cachedSize = [self calculateSizeForContainerSize:containerSize];
    _hasCalculatedSize = true;
    return _cachedSize;
}

- (CGSize)calculateSizeForContainerSize:(CGSize)containerSize {
    return CGSizeZero;
}

- (void)clearCachedSize {
    _hasCalculatedSize = false;
    _cachedSize = CGSizeZero;
}

- (BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object {
    return object == self;
}

- (id<NSObject>)diffIdentifier {
    return self;
}

@end
