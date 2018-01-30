//
//  CustomCellModel.h
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/8.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "BaseDataCellModel.h"
#import "CustomData.h"

@interface CustomCellModel : BaseDataCellModel<CustomData *>

@property (nonatomic, strong) UIColor *backgroundColor;

@end
