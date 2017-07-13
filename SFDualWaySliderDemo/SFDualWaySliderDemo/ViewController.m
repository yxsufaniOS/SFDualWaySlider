//
//  ViewController.m
//  SFDualWaySliderDemo
//
//  Created by 苏凡 on 2017/6/16.
//  Copyright © 2017年 sf. All rights reserved.
//

#import "ViewController.h"
#import "SFDualWaySlider.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SFDualWaySlider *slider = [[SFDualWaySlider alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 70) minValue:0 maxValue:80 blockSpaceValue:0];
    slider.progressRadius = 5;
    [slider.minIndicateView setTitle:@"不限"];
    [slider.maxIndicateView setTitle:@"不限"];
    slider.lightColor = [UIColor yellowColor];
    slider.minIndicateView.backIndicateColor = [UIColor greenColor];
    slider.maxIndicateView.backIndicateColor = [UIColor greenColor];
    
    slider.sliderValueChanged = ^(CGFloat minValue, CGFloat maxValue) {
        
    
    };
    
    //设置标题，如果需要设置默认值 最好先写这个，否则设置默认值后不会第一时间触发
    slider.getMinTitle = ^NSString *(CGFloat minValue) {
        if (floor(minValue) == 0.f) {
            return @"不限";
        }else{
            return [NSString stringWithFormat:@"%.fK",floor(minValue)];
        }
        
    };
    
    slider.getMaxTitle = ^NSString *(CGFloat maxValue) {
        if (floor(maxValue) == 80.f) {
            return @"不限";
        }else{
            return [NSString stringWithFormat:@"%.fK",floor(maxValue)];
        }
    };
    
    slider.currentMinValue = 0;
    slider.currentMaxValue = 30;
    //分段 表示前部分占比80%  所在值范围为[0,30]  即剩下的 20%滑动距离 值范围为[30，80]
    slider.frontScale = 0.8;
    slider.frontValue = 30;
    
    slider.indicateViewOffset = 10;
    slider.indicateViewWidth = 40;
    
    [self.view addSubview:slider];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
