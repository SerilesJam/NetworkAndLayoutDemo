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
#import "Routable.h"
#import "AsyncSocket.h"
#import "PageViewController.h"

#import "WSWaveEmitterView.h"

@interface ViewController () <AsyncSocketDelegate>

@property (nonatomic, strong) ColorView *colorView;
@property (weak, nonatomic) IBOutlet WSWaveEmitterView *waveEmitterView;

@end

@implementation ViewController

+ (id)allocWithRouterParams:(NSDictionary *)params {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *instance = [storyboard instantiateInitialViewController];
    
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.colorView = [[ColorView alloc] initWithFrame:CGRectZero];
//    [self.colorView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    
//    [self.view addSubview:self.colorView];
    
    AsyncSocket *socket=[[AsyncSocket alloc] initWithDelegate:self];
    [socket connectToHost:@"www.mayiw.com" onPort:80 error:nil];
    
    [socket readDataWithTimeout:3 tag:1];
    [socket writeData:[@"GET /suzhou/index.html HTTP/1.1\nHost:www.mayiw.com\n\n" dataUsingEncoding:NSUTF8StringEncoding] withTimeout:3 tag:1];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.waveEmitterView emitImage:[UIImage imageNamed:@"heart"]];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
//    UIEdgeInsets padding = UIEdgeInsetsMake(self.topLayoutGuide.length+10, 10, 10, 10);
//    
//    [self.colorView mas_makeConstraints:^(MASConstraintMaker *make){
//        make.edges.equalTo(self.view).insets(padding);
//    }];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark AsyncSocketDelegate

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    NSLog(@"did connect to host");
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"did read data");
    NSString* message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"message is: \n%@",message);
}

- (IBAction)onClick:(id)sender {
    [self.waveEmitterView emitImage:[UIImage imageNamed:@"heart"]];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    PageViewController *instance = [storyboard instantiateViewControllerWithIdentifier:@"page"];
//    
//    [self.navigationController pushViewController:instance animated:YES];
//    [[Routable sharedRouter] open:@"page"];
}

@end
