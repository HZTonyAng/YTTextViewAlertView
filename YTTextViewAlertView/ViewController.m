//
//  ViewController.m
//  YTTextViewAlertView
//
//  Created by TonyAng on 2018/4/23.
//  Copyright © 2018年 TonyAng. All rights reserved.
//

#import "ViewController.h"
#import "YTTextViewAlertView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"YTTextViewAlertView";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.frame = CGRectMake(0, 0, 100, 100);
    button.center = self.view.center;
    button.backgroundColor = [UIColor cyanColor];
    [button addTarget:self action:@selector(butttonAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)butttonAction{
    YTTextViewAlertView *alertView = [YTTextViewAlertView new];
    [alertView show];
    
    alertView.ytAlertViewMakeSureBlock = ^(NSString *repulse_evaluate_str) {
        NSLog(@"打回了------VC");

    };
    
    alertView.ytAlertViewCloseBlock = ^{
        NSLog(@"取消了------VC");
    };
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
