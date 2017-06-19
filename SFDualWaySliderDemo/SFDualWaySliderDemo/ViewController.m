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
    
    SFDualWaySlider *slider = [[SFDualWaySlider alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 70) minValue:0 maxValue:80 blockSpaceValue:2];
    slider.progressRadius = 5;
    [slider.minIndicateView setTitle:@"不限"];
    [slider.maxIndicateView setTitle:@"不限"];
    slider.lightColor = [UIColor yellowColor];
    slider.minIndicateView.backIndicateColor = [UIColor greenColor];
    slider.maxIndicateView.backIndicateColor = [UIColor greenColor];
    slider.indicateViewOffset = 10;
    slider.indicateViewWidth = 80;
    slider.sliderValueChanged = ^(CGFloat minValue, CGFloat maxValue) {
        
    
    };
    
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
    [self.view addSubview:slider];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
