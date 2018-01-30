//
//  CustomData.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/8.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "CustomData.h"

@implementation CustomData

- (nonnull id<NSObject>)diffIdentifier {
    return @(self.index);
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object {
    CustomData *data = (CustomData *)object;
    if ([data isKindOfClass:[CustomData class]]) {
        return data.index == _index;
    }
    return false;
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if (![super isEqual:other]) {
        return NO;
    } else {
        return NO;
    }
}


@end
