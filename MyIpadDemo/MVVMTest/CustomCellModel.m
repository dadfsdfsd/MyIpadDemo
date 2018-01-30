//
//  CustomCellModel.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/8.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "CustomCellModel.h"

@implementation CustomCellModel

- (CGSize)calculateSizeForContainerSize:(CGSize)containerSize {
//    return CGSizeMake((containerSize.width - 40)/1, (containerSize.width - 40)/1);
    
    return CGSizeMake((containerSize.width - 40)/1, 50);
}

- (BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object {
    
    return [super isEqualToDiffableObject:object] && [self.backgroundColor isEqual:[(CustomCellModel *)object backgroundColor]];
}

@end
