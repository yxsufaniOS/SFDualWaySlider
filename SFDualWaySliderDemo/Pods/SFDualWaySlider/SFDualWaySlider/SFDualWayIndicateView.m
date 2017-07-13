//
//  SFDualWayIndicateView.m
//  MyWallet
//
//  Created by 苏凡 on 2017/5/18.
//  Copyright © 2017年 sf. All rights reserved.
//

#import "SFDualWayIndicateView.h"
#import <Masonry.h>
// 将角度转为弧度
#define kSF_DEGREES_TO_RADOANS(x) (M_PI * (x) / 180.0)


@implementation SFDualWayIndicateView{
    SFDualWayIndicateDirection _direction;
}

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        _backIndicateColor = [UIColor colorWithRed:0.24 green:0.61 blue:0.91 alpha:1.00];
        _indicateLabel = [[UILabel alloc] init];
        _indicateLabel.backgroundColor = [UIColor colorWithRed:0.24 green:0.61 blue:0.91 alpha:1.00];
        _indicateLabel.textColor       = [UIColor whiteColor];
        _indicateLabel.font            = [UIFont systemFontOfSize:15];
        _indicateLabel.textAlignment   = NSTextAlignmentCenter;
        _indicateLabel.layer.cornerRadius = 4;
        _indicateLabel.layer.masksToBounds = YES;
    
        [self addSubview:_indicateLabel];
        [_indicateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.width.equalTo(self);
            make.height.equalTo(@21);
        }];
        self.layer.anchorPoint = CGPointMake(0.5, 1);
        
        _direction = SFDualWayIndicateDirectionNomal;
    }
    return self;
}


- (void)setTitle:(NSString *)title{
    _indicateLabel.text = title;
}

- (void)setDirection:(SFDualWayIndicateDirection)direction{
    if (direction == _direction) {
        return;
    }
    _direction = direction;
    CGFloat s = direction == SFDualWayIndicateDirectionLeft? kSF_DEGREES_TO_RADOANS(-30) : (direction == SFDualWayIndicateDirectionRight? kSF_DEGREES_TO_RADOANS(30) : kSF_DEGREES_TO_RADOANS(0));
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeRotation(s);
    }];
    
}

- (void)setDirectionAnimateToNomal{
    [self setDirection:SFDualWayIndicateDirectionNomal];
}

- (void)setBackIndicateColor:(UIColor *)backIndicateColor{
    
    _backIndicateColor = backIndicateColor;
    _indicateLabel.backgroundColor = backIndicateColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    [self drawBackground:self.bounds inContext:UIGraphicsGetCurrentContext()];
}

- (void)drawBackground:(CGRect)frame
             inContext:(CGContextRef) context
{
    
    CGFloat left = CGRectGetMidX(frame) - 6;
    CGFloat right = CGRectGetMidX(frame) + 6;
    CGFloat y0 = 21;
    CGFloat y1 = frame.size.height;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(left, y0)];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(frame), y1)];
    [path addLineToPoint:CGPointMake(right, y0)];
    [path closePath];
    
    [_backIndicateColor set];
    [_backIndicateColor setStroke];
    [path stroke];
    [path fill];
}


@end
