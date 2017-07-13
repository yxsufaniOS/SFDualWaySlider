//
//  SFDualWaySlider.m
//  MyWallet
//
//  Created by 苏凡 on 2017/5/18.
//  Copyright © 2017年 sf. All rights reserved.
//

#import "SFDualWaySlider.h"
//#import "SFDualWayIndicateView.h"
#import <Masonry.h>

#define kSF_HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0f green:((c>>8)&0xFF)/255.0f blue:(c&0xFF)/255.0f alpha:1.0f]

@implementation SFDualWaySlider{
    UIView *_progressView;
    UIView *_lightView;
    UIButton *_minButton;
    UIButton *_maxButton;
    CGFloat _minValue;//当前最小进度
    CGFloat _maxValue;//当前最大进度
    CGFloat _blockSpace;//间隔宽度
    CGFloat _blockSpaceValue;//间隔所代表的值
    CGFloat _progressWidth;//横条宽度
    CGFloat _totalSpaceValue;//横条所代表的值的大小  最大值 减 最小值 减 间隔值
}



/**
 初始化函数
 
 @param frame 位置
 @param minValue 最小值
 @param maxValue 最大值
 @param blockSpaceValue 两个滑块间隔的值
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue blockSpaceValue:(CGFloat)blockSpaceValue{
    return [self initWithFrame:frame image:[UIImage imageNamed:@"huakuai_icon"] minValue:minValue maxValue:maxValue blockSpaceValue:blockSpaceValue];
}

- (instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame image:[UIImage imageNamed:@"huakuai_icon"] minValue:2.f maxValue:90.f blockSpaceValue:1.f];
}

/**
 初始化函数
 
 @param frame 位置
 @param image 图标
 @param minValue 最小值
 @param maxValue 最大值
 @param blockSpaceValue 两个滑块间隔的值
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue blockSpaceValue:(CGFloat)blockSpaceValue{
    if (self = [super initWithFrame:frame]) {
        _blockImage        = image;
        _spaceInBlocks     = 10.f;
        _blockSpace        = image.size.width + _spaceInBlocks;
        _blockSpaceValue   = blockSpaceValue;
        _minSetValue       = minValue;
        _maxSetValue       = maxValue;
        _currentMinValue   = _minSetValue;
        _currentMaxValue   = _maxSetValue;
        _totalSpaceValue   = (_maxSetValue - _minSetValue - _blockSpaceValue);
        _frontValue        = _totalSpaceValue/2.f;
        _frontScale        = 0.5f;
        _minValue          = 0.f;
        _maxValue          = 1.f;
        _progressLeftSpace = 20.f;
        _progressHeight    = 10.f;
        _progressRadius    = 0.f;
        _lightColor        = [UIColor colorWithRed:0.24 green:0.61 blue:0.91 alpha:1.00];
        _darkColor         = kSF_HEXCOLOR(0xf2f2f2);
        _showAnimate       = YES;
        _progressWidth     = self.frame.size.width - _progressLeftSpace*2;
        _indicateViewOffset = 3;
        _indicateViewWidth  = 35;
        [self initSliderUI];
    }
    return self;
}


- (void)setBlockImage:(UIImage *)blockImage{
    if (!blockImage) return;
    _blockImage = blockImage;
    [_minButton setImage:blockImage forState:UIControlStateNormal];
    [_maxButton setImage:blockImage forState:UIControlStateNormal];
    _blockSpace = blockImage.size.width + _spaceInBlocks;
}

- (void)setSpaceInBlocks:(CGFloat)spaceInBlocks{
    _spaceInBlocks = spaceInBlocks;
    _blockSpace = _blockImage.size.width + _spaceInBlocks;
}

- (void)setCurrentMinValue:(CGFloat)currentMinValue{
    if (currentMinValue > (_currentMaxValue-_blockSpaceValue)) {
        NSLog(@"大于当前max的值");
        return;
    }else if (currentMinValue < _minSetValue){
        NSLog(@"低于最小值");
        return;
    }
    _currentMinValue = currentMinValue;
    
    if (_currentMinValue > (_frontValue + _minSetValue)) {
        _minValue = _frontScale + (_currentMinValue - _frontValue - _minSetValue)/(_totalSpaceValue - _frontValue) * (1 - _frontScale);
    }else {
        _minValue = (_currentMinValue - _minSetValue)/_frontValue * _frontScale;
    }
    
    CGFloat x = _minValue * (_progressWidth-_blockSpace);
    if (self.getMinTitle) {
        [_minIndicateView setTitle:self.getMinTitle(_currentMinValue)];
    }
    
    [_minButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_progressView.mas_left).offset(x);
    }];
}

- (void)setCurrentMaxValue:(CGFloat)currentMaxValue{
    if (currentMaxValue < (_currentMinValue + _blockSpaceValue)) {
        NSLog(@"小于当前min的值");
        return;
    }else if (currentMaxValue > _maxSetValue){
        NSLog(@"大于最大值");
        return;
    }
    _currentMaxValue = currentMaxValue;
    
    if (_currentMaxValue > (_frontValue + _blockSpaceValue + _minSetValue)) {
        _maxValue = (_currentMaxValue - _frontValue - _blockSpaceValue - _minSetValue)/(_totalSpaceValue - _frontValue)*(1 - _frontScale) + _frontScale;
    }else {
        _maxValue = (_currentMaxValue - _blockSpaceValue - _minSetValue)/_frontValue * _frontScale;
    }
    
    
    CGFloat y = (1 - _maxValue)*(_progressWidth-_blockSpace);
    if (self.getMaxTitle) {
        [_maxIndicateView setTitle:self.getMaxTitle(_currentMaxValue)];
    }
    [self didcurrentMaxOrMinValueChanged];
    
    [_maxButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_progressView.mas_right).offset(-y);
    }];
}

- (void)setProgressHeight:(CGFloat)progressHeight{
    _progressHeight = progressHeight;
    [_progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(progressHeight);
    }];
}

- (void)setProgressRadius:(CGFloat)progressRadius{
    _progressRadius = progressRadius;
    _progressView.layer.cornerRadius = progressRadius;
}

- (void)setIndicateViewOffset:(CGFloat)indicateViewOffset{
    _indicateViewOffset = indicateViewOffset;
    [_minIndicateView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_minButton.mas_centerY).offset(-_indicateViewOffset);
    }];
    [_maxIndicateView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_maxButton.mas_centerY).offset(-_indicateViewOffset);
    }];
}

- (void)setIndicateViewWidth:(CGFloat)indicateViewWidth{
    _indicateViewWidth = indicateViewWidth;
    [_minIndicateView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(_indicateViewWidth);
    }];
    [_maxIndicateView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(_indicateViewWidth);
    }];
}

- (void)setLightColor:(UIColor *)lightColor{
    _lightColor = lightColor;
    _lightView.backgroundColor = lightColor;
}
- (void)setDarkColor:(UIColor *)darkColor{
    _darkColor = darkColor;
    _progressView.backgroundColor = darkColor;
}

- (void)setFrontScale:(CGFloat)frontScale{
    if (frontScale >= 1 || frontScale <= 0) return;
    _frontScale = frontScale;
}

- (void)setFrontValue:(CGFloat)frontValue{
    if (frontValue >= _totalSpaceValue || frontValue <= 0) return;
    _frontValue = frontValue;
}

- (void)setProgressLeftSpace:(CGFloat)progressLeftSpace{
    if (progressLeftSpace == _progressLeftSpace) return;
    _progressLeftSpace = progressLeftSpace;
    _progressWidth     = self.frame.size.width - _progressLeftSpace*2;
    [_progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(progressLeftSpace));
        make.right.equalTo(@(-progressLeftSpace));
    }];
}

- (void)initSliderUI{
    _progressView = [[UIView alloc] init];
    _progressView.layer.masksToBounds = YES;
    _progressView.layer.cornerRadius = _progressRadius;
    _progressView.backgroundColor = _darkColor;
    _lightView = [[UIView alloc] init];
    _lightView.backgroundColor = _lightColor;
    
    _minButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _minButton.backgroundColor = [UIColor clearColor];
    _minButton.adjustsImageWhenHighlighted = NO;
    [_minButton setImage:_blockImage forState:UIControlStateNormal];
    
    _maxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _maxButton.backgroundColor = [UIColor clearColor];
    _maxButton.adjustsImageWhenHighlighted = NO;
    [_maxButton setImage:_blockImage forState:UIControlStateNormal];
    
    
    UIPanGestureRecognizer *minButtonPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMinAction:)];
    [minButtonPan setMaximumNumberOfTouches:1];
    [_minButton addGestureRecognizer:minButtonPan];
    
    UIPanGestureRecognizer *maxButtonPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMaxAction:)];
    [maxButtonPan setMaximumNumberOfTouches:1];
    [_maxButton addGestureRecognizer:maxButtonPan];
    
    UIPanGestureRecognizer *minIndicatePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMinAction:)];
    [minIndicatePan setMaximumNumberOfTouches:1];
    
    UIPanGestureRecognizer *maxIndicatePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMaxAction:)];
    [maxIndicatePan setMaximumNumberOfTouches:1];
    _minIndicateView = [[SFDualWayIndicateView alloc] init];
    [_minIndicateView addGestureRecognizer:minIndicatePan];
    
    _maxIndicateView = [[SFDualWayIndicateView alloc] init];
    [_maxIndicateView addGestureRecognizer:maxIndicatePan];
    
    [self addSubview:_progressView];
    [self addSubview:_lightView];
    [self addSubview:_minButton];
    [self addSubview:_maxButton];
    [self addSubview:_minIndicateView];
    [self addSubview:_maxIndicateView];
    
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(_progressLeftSpace));
        make.right.equalTo((@(-_progressLeftSpace)));
        make.height.mas_offset(_progressHeight);
        make.centerY.equalTo(_minButton);
    }];
    
    [_lightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerY.equalTo(_progressView);
        make.left.equalTo(_minButton.mas_centerX);
        make.right.equalTo(_maxButton.mas_centerX);
    }];
    
    [_minButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_progressView.mas_left).offset(0);
        make.bottom.equalTo(self);
    }];
    
    
    [_maxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.centerX.equalTo(_progressView.mas_right).offset(0);
    }];
    
    [_minIndicateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_minButton);
        make.width.mas_offset(_indicateViewWidth);
        make.height.mas_offset(28);
        //_minIndicateView 修改了 anchorPoint 所以参照的是centerY
        make.bottom.equalTo(_minButton.mas_centerY).offset(-_indicateViewOffset);
    }];

    [_maxIndicateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_maxButton);
        make.width.mas_offset(_indicateViewWidth);
        make.height.mas_offset(28);
        //_maxIndicateView 修改了 anchorPoint 所以参照的是centerY
        make.bottom.equalTo(_maxButton.mas_centerY).offset(-_indicateViewOffset);
    }];
}

- (void)didcurrentMaxOrMinValueChanged{
    if (self.sliderValueChanged) {
        self.sliderValueChanged(_currentMinValue, _currentMaxValue);
    }
}

- (void)panMinAction:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan locationInView:self];
    static CGFloat lastX ;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            [self bringSubviewToFront:_minIndicateView];
            [self bringSubviewToFront:_minButton];
            lastX = point.x;
            break;
        }
        case UIGestureRecognizerStateChanged:{
            CGFloat x = (point.x - _progressLeftSpace);
            if (point.x <= _progressLeftSpace) {
                x = 0.f;
            }else if (point.x >= ( _maxValue * (_progressWidth - _blockSpace) + _progressLeftSpace)){
                x = _maxValue * (_progressWidth - _blockSpace);
            }else{
                x = (point.x - _progressLeftSpace);
            }
            _minValue = x/(_progressWidth-_blockSpace);
            
            if (_minValue > _frontScale) {
                _currentMinValue = (_minValue - _frontScale)/(1 -_frontScale)*(_totalSpaceValue - _frontValue) +_frontValue + _minSetValue;
            }else {
                _currentMinValue = _minValue/_frontScale * _frontValue + _minSetValue;
            }
            [self didcurrentMaxOrMinValueChanged];
            
            if (self.getMinTitle) {
                [_minIndicateView setTitle:self.getMinTitle(_currentMinValue)];
            }
            
            [_minButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_progressView.mas_left).offset(x);
            }];
            
            if (!_showAnimate) break;
            if (lastX > point.x) {
                [_minIndicateView setDirection:SFDualWayIndicateDirectionRight];
            }else if (lastX < point.x){
                [_minIndicateView setDirection:SFDualWayIndicateDirectionLeft];
            }
            lastX = point.x;
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:{
            [_minIndicateView setDirection:SFDualWayIndicateDirectionNomal];
            break;
        }
        default:
            break;
    }
    
}

- (void)panMaxAction:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan locationInView:self];
    static CGFloat lastX ;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            [self bringSubviewToFront:_maxIndicateView];
            [self bringSubviewToFront:_maxButton];
            lastX = point.x;
            break;
        }
        case UIGestureRecognizerStateChanged:{
            CGFloat y = _progressWidth - (point.x - _progressLeftSpace);
            if (point.x >=  (_progressWidth + _progressLeftSpace)) {
                y = 0;
            }else if (point.x <= (_minValue * (_progressWidth-_blockSpace) + _progressLeftSpace + _blockSpace)){
                y = _progressWidth - (_minValue * (_progressWidth-_blockSpace) + _blockSpace);
            }else{
                y = (_progressWidth + _progressLeftSpace) - point.x;
            }
            _maxValue = 1 - y/(_progressWidth-_blockSpace);
            if (_maxValue > _frontScale) {
                _currentMaxValue = (_maxValue - _frontScale)/(1 - _frontScale)*(_totalSpaceValue - _frontValue) +_frontValue + _blockSpaceValue + _minSetValue;
            }else {
                _currentMaxValue = _maxValue/_frontScale * _frontValue +_blockSpaceValue + _minSetValue;
            }
            
    
            if (self.getMaxTitle) {
                [_maxIndicateView setTitle:self.getMaxTitle(_currentMaxValue)];
            }
            
            [self didcurrentMaxOrMinValueChanged];
            
            [_maxButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_progressView.mas_right).offset(-y);
            }];
            
            if (!_showAnimate) break;
            if (lastX > point.x) {
                [_maxIndicateView setDirection:SFDualWayIndicateDirectionRight];
            }else if (lastX < point.x){
                [_maxIndicateView setDirection:SFDualWayIndicateDirectionLeft];
            }
            lastX = point.x;
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:{
            [_maxIndicateView setDirection:SFDualWayIndicateDirectionNomal];
            break;
        }
        default:
            break;
    }
}

@end
