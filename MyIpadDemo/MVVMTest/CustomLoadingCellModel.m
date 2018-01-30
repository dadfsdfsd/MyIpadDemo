//
//  CustomLoadingCellModel.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/26.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "CustomLoadingCellModel.h"

@implementation CustomLoadingCellModel


- (CGSize)expectedSizeForContainerSize:(CGSize)containerSize {
    return CGSizeMake(containerSize.width, 80);
}

@end
