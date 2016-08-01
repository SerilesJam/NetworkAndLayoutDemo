//
//  PageViewController.m
//  NetworkAndLayout
//
//  Created by 贾淼 on 16/7/24.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "PageViewController.h"

@implementation PageViewController

+ (id)allocWithRouterParams:(NSDictionary *)params {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PageViewController *instance = [storyboard instantiateViewControllerWithIdentifier:@"page"];
    
    return instance;
}

- (void)dealloc {
    NSLog(@"dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
