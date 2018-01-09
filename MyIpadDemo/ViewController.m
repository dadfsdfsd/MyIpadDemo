//
//  ViewController.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/3.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "CustomCollectionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [button addTarget:self action:@selector(onTapButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
}

- (void)onTapButton {
    UIViewController *vc = [CustomCollectionViewController new];
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:vc animated:true completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
