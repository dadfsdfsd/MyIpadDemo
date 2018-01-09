//
//  SelectViewController.h
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/3.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectViewControllerDelegate

@optional

- (void)selectViewController:(UITableView *)SelectViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end

@interface SelectViewController : UITableViewController

@property(nonatomic, weak) id<SelectViewControllerDelegate> delegate;

@end
