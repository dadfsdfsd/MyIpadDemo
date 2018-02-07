//
//  SelectTableViewCell.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/3.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "SelectTableViewCell.h"
 

@implementation SelectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setTitle:(NSString *)title {
    self.textLabel.text = title;
}


@end
