//
//  ViewController.m
//  VXToolsDemo
//
//  Created by 张新 on 16/9/30.
//  Copyright © 2016年 voidxin. All rights reserved.
//

#import "ViewController.h"
#import "VXTools.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //获取屏幕的宽度
    CGFloat width = [VXTools screenWidth];
    NSLog(@"width : %f",width);
    
    //格式化时间
    NSString *date = [VXTools DateTimeWithFormateNowString:@"yyyy-MM-dd"];
    NSLog(@"date is :%@",date);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
