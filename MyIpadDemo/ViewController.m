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
#import <BlocksKit+UIKit.h>
#import "NSObject+A2DynamicDelegate.h"
#import "NSObject+ObservationManager.h"
//#import "n"

@protocol DoSomeProtocol

- (void) doSome:(NSNumber *)i;

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [button addTarget:self action:@selector(onTapButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    [ViewController test:@"sdf", nil];
    [self test];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"" message:@"1" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:alertAction];
        [self presentViewController:ac animated:true completion:nil];
    });
}

- (void)test {
    NSString *str = @"aa";
    NSString *str2 = [NSString stringWithFormat:@"aa"];
//    BOOL result = str == str2;
    BOOL result = [str isEqual:str2];
    
    NSArray *arr1 = @[str];
    NSArray *arr2 = @[str2];
    
    BOOL result2 = [arr1 isEqual:arr2];
    BOOL result3 = arr1 == arr2;
    
    NSLog(@"%d",result);
}

- (void)onTapButton {
    UIViewController *vc = [CustomCollectionViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navigationController animated:true completion:nil];
}


- (void)showAlertView {
    UIAlertView *alertView = [UIAlertView bk_showAlertViewWithTitle:@"aaa" message:@"aaa" cancelButtonTitle:@"aaa" otherButtonTitles:@[@"aaa"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        NSLog(@"AlertView");
    }];
    
    void(^doSome)(NSNumber *) = ^(NSNumber * i) {
        NSLog(@"%d", i.intValue);
    };
    [[alertView bk_dynamicDelegate] implementMethod:@selector(doSome:) withBlock:doSome];
    
    [(id<DoSomeProtocol>)[alertView bk_dynamicDelegate] doSome:@(2)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(instancetype)test:(NSString *)inOtherButtonItems, ... {
    va_list argumentList;
    
    NSMutableArray *array = [NSMutableArray new];
    NSString *eachItem = nil;
    
    if (inOtherButtonItems)
    {
        va_start(argumentList, inOtherButtonItems);
        while((eachItem = va_arg(argumentList, NSString *)))
        {
            [array addObject: eachItem];
        }
        va_end(argumentList);
    }
    return [ViewController new];
}


@end
