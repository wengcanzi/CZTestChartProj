//
//  VMLineButton.m
//  VehicleMonitoring
//
//  Created by cz on 2018/12/28.
//  Copyright © 2018年 ShenzhenRuiXunYiTong. All rights reserved.
//

#import "VMLineButton.h"

@interface VMLineButton ()

@property (nonatomic,strong) UIView *buttonView;

@end

@implementation VMLineButton

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.buttonView.center = self.center;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:[UIColor clearColor]];
    self.buttonView.backgroundColor = backgroundColor;
}

- (UIView *)buttonView {
    if (!_buttonView) {
        _buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
        _buttonView.layer.cornerRadius = 4;
        _buttonView.clipsToBounds = YES;
        _buttonView.userInteractionEnabled = NO;
        [self addSubview:_buttonView];
    }
    return _buttonView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
