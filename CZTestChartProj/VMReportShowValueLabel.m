//
//  VMReportShowValueLabel.m
//  VehicleMonitoring
//
//  Created by cz on 2018/12/28.
//  Copyright © 2018年 ShenzhenRuiXunYiTong. All rights reserved.
//

#import "VMReportShowValueLabel.h"

@interface VMReportShowValueLabel()
    
@property (nonatomic,strong) UILabel *textLabel;

@end

@implementation VMReportShowValueLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height/100.*72);
        self.image = [UIImage imageNamed:@"report_bubble"];
        [self addSubview:_textLabel];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _textLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height/100.*72);
}

- (void)setText:(NSString *)text {
    _text = text;
    _textLabel.text = text;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textAlignment = 1;
//        _textLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _textLabel.textColor = [UIColor whiteColor];
//        _showValueLabel.layer.cornerRadius = 3;
//        _showValueLabel.clipsToBounds = YES;
        _textLabel.font = [UIFont systemFontOfSize:12];
        _textLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_textLabel];
    }
    return _textLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
