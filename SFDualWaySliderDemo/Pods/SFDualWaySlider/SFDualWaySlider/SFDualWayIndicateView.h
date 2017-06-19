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

@property (strong, nonatomic) UIColor *backIndicateColor;
- (void)setTitle:(NSString *)title;
- (void)setDirection:(SFDualWayIndicateDirection)direction;
- (void)setDirectionAnimateToNomal;

@end
