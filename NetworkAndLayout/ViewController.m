//
//  ViewController.m
//  NetworkAndLayout
//
//  Created by Jam on 16/5/10.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import <NetworkAndLayout-swift.h>

@interface ViewController ()

@property (nonatomic, strong) ColorView *colorView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.colorView = [[ColorView alloc] initWithFrame:CGRectZero];
    [self.colorView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:self.colorView];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(self.topLayoutGuide.length+10, 10, 10, 10);
    
    [self.colorView mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.view).insets(padding);
    }];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
