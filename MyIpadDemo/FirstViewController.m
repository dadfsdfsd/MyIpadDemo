//
//  FirstViewController.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/3.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property(nonatomic, strong) UISplitViewController* splitViewController;

@property(nonatomic, strong) SelectViewController* selectViewController;

@property(nonatomic, strong) ColorViewController* colorViewController;

@end

@implementation FirstViewController


- (id)init
{
    if ((self = [self initWithNibName:nil bundle:nil])) {
        [self setupSplitViewController];
    }
    return self;
}


- (void)setupSplitViewController {
    
    _selectViewController = [SelectViewController new];
    _selectViewController.delegate = self;
    
    _colorViewController = [ColorViewController new];
    _colorViewController.backgroundColor = [UIColor redColor];
    
    _splitViewController = [UISplitViewController new];
    _splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    _splitViewController.maximumPrimaryColumnWidth = 200;
    _splitViewController.minimumPrimaryColumnWidth = 50;
    _splitViewController.delegate = self;
    _splitViewController.viewControllers = @[_selectViewController, _colorViewController];
    
    [self addChildViewController:_splitViewController];
    [self.view addSubview:_splitViewController.view];
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _splitViewController.view.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)selectViewController:(UITableView *)SelectViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
//    UIColor *color = [UIColor colorWithRed:indexPath.row/10.0 green:0 blue:0 alpha:1];
//
//    ColorViewController* colorViewController = [ColorViewController new];
//    colorViewController.backgroundColor = color;
//    [_splitViewController showDetailViewController:colorViewController sender:nil];
    
//    _colorViewController.backgroundColor = color;
}




@end
