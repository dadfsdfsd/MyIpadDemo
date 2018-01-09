//
//  SelectViewController.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/3.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "SelectViewController.h"
#import "SelectTableViewCell.h"



@interface SelectViewController ()

@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:SelectTableViewCell.class forCellReuseIdentifier:@"SelectTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectTableViewCell *cell = (SelectTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"SelectTableViewCell"];
    cell.title = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [_delegate selectViewController:self didSelectRowAtIndexPath:indexPath];
}



@end
