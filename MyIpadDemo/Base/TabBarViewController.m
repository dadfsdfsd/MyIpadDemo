//
//  TabBarViewController.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/2/7.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "TabBarViewController.h"
#import "ViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"" message:@"0" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:alertAction];
        [self.presentedViewController presentViewController:ac animated:true completion:nil];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViewControllers {
    UITabBarItem *firstItem = [[UITabBarItem alloc] initWithTitle:@"first" image:nil tag:0];
    ViewController *firstVC = [ViewController new];
    firstVC.tabBarItem = firstItem;
    [self setViewControllers:@[firstVC]];
}



@end
