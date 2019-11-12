//
//  ViewController.m
//  WaterDemo
//
//  Created by xckj on 2019/11/12.
//  Copyright © 2019 三皮. All rights reserved.
//

#import "ViewController.h"
#import "SPWaterView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(clickAnimation:) userInfo:nil repeats:YES];
}

- (void)clickAnimation:(id)sender {
    
    __block SPWaterView *waterView = [[SPWaterView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, 200, 100, 100)];
    waterView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:waterView];
}

@end
