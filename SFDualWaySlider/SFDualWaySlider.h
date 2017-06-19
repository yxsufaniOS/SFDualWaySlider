//
//  SFDualWaySlider.h
//  MyWallet
//
//  Created by 苏凡 on 2017/5/18.
//  Copyright © 2017年 sf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFDualWayIndicateView.h"

@interface SFDualWaySlider : UIView


/**
 初始化函数
 
 @param frame 位置 总体高度以滑块为底部开始布局 指示标的高度为28 
 @param minValue 最小值
 @param maxValue 最大值
 @param blockSpaceValue 两个滑块间隔的所代表的值
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue blockSpaceValue:(CGFloat)blockSpaceValue;


/**
 初始化函数
 
 @param frame 位置  总体高度以滑块为底部开始布局 指示标的高度为28
 @param image 图标
 @param minValue 最小值
 @param maxValue 最大值
 @param blockSpaceValue 两个滑块间隔的值
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue blockSpaceValue:(CGFloat)blockSpaceValue;

@property (assign, nonatomic) CGFloat currentMinValue;//当前小滑块所代表的值，可设置
@property (assign, nonatomic) CGFloat currentMaxValue;//当前大滑块所代表的值，可设置
@property (assign, nonatomic, readonly) CGFloat minSetValue;//当前设置的最小值
@property (assign, nonatomic, readonly) CGFloat maxSetValue;//当前设置的最大值
@property (assign, nonatomic) CGFloat frontValue;//前段所代表的值 默认 最小到最大的一半 
@property (assign, nonatomic) CGFloat frontScale;//分段比例  （0～1） 默认0.5；
@property (assign, nonatomic) CGFloat progressLeftSpace;//横条左间距 默认 20;
@property (assign, nonatomic) CGFloat progressHeight;//横条高度 默认 10
@property (assign, nonatomic) CGFloat progressRadius;//横条圆角 默认 0
@property (assign, nonatomic) CGFloat spaceInBlocks;//滑块之间的间距 默认 10
@property (assign, nonatomic) CGFloat indicateViewOffset;//滑块和指示视图之间的间距 默认 3
@property (assign, nonatomic) CGFloat indicateViewWidth;//指示视图宽度 默认 35
@property (strong, nonatomic) UIImage *blockImage;//滑块图标
@property (strong, nonatomic) UIColor *lightColor;//点亮颜色
@property (strong, nonatomic) UIColor *darkColor;//背景色
@property (assign, nonatomic) BOOL    showAnimate;//滑块动作 默认 YES
@property (strong, nonatomic, readonly) SFDualWayIndicateView *minIndicateView;//滑块指示视图
@property (strong, nonatomic, readonly) SFDualWayIndicateView *maxIndicateView;//滑块指示视图

/**
 滑块值变化调用的block 最大 最小变化都会调用
 */
@property (copy  , nonatomic) void(^sliderValueChanged)(CGFloat minValue,CGFloat maxValue);

/**
 获取小指标的标题
 */
@property (copy  , nonatomic) NSString *(^getMinTitle)(CGFloat minValue);

/**
 获取大指标的标题
 */
@property (copy  , nonatomic) NSString *(^getMaxTitle)(CGFloat maxValue);

@end
