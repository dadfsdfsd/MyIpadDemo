//
//  BaseCellModel.h
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/5.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <IGListKit/IGListKit.h>

@protocol BaseCellModel<NSObject, IGListDiffable>

+ (NSString *)cellIdentifier;

- (CGSize)calculateSizeForContainerSize:(CGSize) containerSize;

- (CGSize)expectedSizeForContainerSize:(CGSize) containerSize;

@end


@interface BaseCellModel : NSObject<BaseCellModel>

@property (nonatomic, assign, readonly) CGSize cachedSize;

+ (NSString *)cellIdentifier;

//need override
- (CGSize)calculateSizeForContainerSize:(CGSize) containerSize;

- (CGSize)expectedSizeForContainerSize:(CGSize) containerSize;


@end





