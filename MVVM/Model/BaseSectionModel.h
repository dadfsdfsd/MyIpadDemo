//
//  BaseSectionModel.h
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/5.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <IGListKit/IGListKit.h>
#import "BaseCellModel.h"


@interface BaseSectionModel : NSObject<IGListDiffable>

@property (nonatomic, strong) NSArray<BaseCellModel*>* cellModels;

@property (nonatomic, strong) id<NSObject> diffIdentifier;

@property (nonatomic, assign) UIEdgeInsets inset;

@property (nonatomic, assign) CGFloat minimumLineSpacing;

@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

@property (nonatomic, strong) BaseCellModel *headerCell;

@property (nonatomic, strong) BaseCellModel *footerCell;

+ (instancetype)sectionModelWithCellModels:(NSArray<BaseCellModel *> *)cellModels;

@end
