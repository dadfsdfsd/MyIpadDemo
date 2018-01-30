//
//  CustomData.h
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/8.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListKit.h>

@interface CustomData : NSObject<IGListDiffable>

@property (nonatomic, assign) NSInteger index;



@end
