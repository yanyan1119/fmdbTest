//
//  ViewController.m
//  FmdbTest
//
//  Created by hky on 16/3/17.
//  Copyright © 2016年 hky. All rights reserved.
//

#import "ViewController.h"
#import "FmdbEngine.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[FmdbEngine shareInstance] startEngine];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
