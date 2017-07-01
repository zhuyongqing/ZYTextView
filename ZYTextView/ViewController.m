//
//  ViewController.m
//  ZYTextView
//
//  Created by zhuyongqing on 2017/7/1.
//  Copyright © 2017年 zhuyongqing. All rights reserved.
//

#import "ViewController.h"
#import "ZYTextToolView.h"
#import "UIView+ITTAdditions.h"
@interface ViewController ()<ZYTextToolViewDelegate>

@end

#define KToolViewHeight 44

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    ZYTextToolView *toolView = [[ZYTextToolView alloc] init];
    toolView.frame = CGRectMake(0, self.view.z_height - KToolViewHeight, self.view.z_width, KToolViewHeight);
    toolView.delegate = self;
    [self.view addSubview:toolView];
}

- (void)textToolViewSendButtonAction:(NSString *)text{
    NSLog(@"send -- %@",text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
