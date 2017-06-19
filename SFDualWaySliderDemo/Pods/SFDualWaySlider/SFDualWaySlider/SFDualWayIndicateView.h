//
//  SFDualWayIndicateView.h
//  MyWallet
//
//  Created by 苏凡 on 2017/5/18.
//  Copyright © 2017年 sf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SFDualWayIndicateDirectionNomal,
    SFDualWayIndicateDirectionLeft,
    SFDualWayIndicateDirectionRight,
} SFDualWayIndicateDirection;

@interface SFDualWayIndicateView : UIView

/**
 背景色
 */
@property (strong, nonatomic) UIColor *backIndicateColor;
@property (strong, nonatomic, readonly) UILabel *indicateLabel;


/**
 设置标题

 @param title 设置标题
 */
- (void)setTitle:(NSString *)title;

/**
 设置指示方向

 @param direction 设置指示方向
 */
- (void)setDirection:(SFDualWayIndicateDirection)direction;

/**
 设置指示方向为正常状态
 */
- (void)setDirectionAnimateToNomal;

@end
