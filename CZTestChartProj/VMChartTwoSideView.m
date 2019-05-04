//
//  VMChartTwoSideView.m
//  CZChartProJ
//
//  Created by cz on 2018/11/1.
//  Copyright © 2018年 ShenzhenRuiXunYiTong. All rights reserved.
//

#import "VMChartTwoSideView.h"

@interface VMChartTwoSideView()

@property(nonatomic,strong) UIView *headView;

@property(nonatomic,strong) VMBarChartView *barChartView;

@property(nonatomic,strong) UIScrollView *bgScrollView;

@property(nonatomic,strong) UILabel *xUnitLabel; //x轴的时间单位

@end


@implementation VMChartTwoSideView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        //head
        [self addHeadView];
        [self addSubview:self.bgScrollView];
    }
    return self;
}

- (void)addHeadView {
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.08)];
    self.headView = headView;
    [self addSubview:self.headView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake( 30, (headView.frame.size.height - 22) / 2, 150, 22)];
    NSString *electricity = @"";
    NSString *title = [NSString stringWithFormat:@"%@(kw-h)", electricity];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor colorWithRed:148.0/255.0 green:148.0/255.0 blue:148.0/255.0 alpha:1.0];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self.headView addSubview:titleLabel];
}

- (VMBarChartView *)barChartView {
    if (!_barChartView) {
        _barChartView = [[VMBarChartView alloc] init];
        [_bgScrollView addSubview:_barChartView];
    }
    return _barChartView;
}

- (UILabel *)xUnitLabel {
    if (!_xUnitLabel) {
        _xUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        _xUnitLabel.textAlignment = 2;
        _xUnitLabel.textColor = [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0];
        _xUnitLabel.font = [UIFont systemFontOfSize:16];
        _xUnitLabel.backgroundColor = [UIColor colorWithRed:243/255. green:244/255. blue:248/255. alpha:1];
        [self addSubview:_xUnitLabel];
    }
    return _xUnitLabel;
}

- (UIScrollView *)bgScrollView {
    if (!_bgScrollView) {
        UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(self.headView.frame), self.frame.size.width-120, self.frame.size.height*0.8)];
        sv.showsVerticalScrollIndicator = NO;
        sv.showsHorizontalScrollIndicator = NO;
        [self addSubview:sv];
        _bgScrollView = sv;
    }
    return _bgScrollView;
}

- (void)addBarChartView {
    CGFloat contentWidth = (self.frame.size.width - 120) * ((self.dataResource.count+1)/7.);
    self.bgScrollView.contentSize = CGSizeMake(contentWidth, CGRectGetHeight(self.frame) * 0.8);
    self.bgScrollView.contentOffset = CGPointZero;
    self.barChartView.frame = CGRectMake(0, 0, contentWidth, self.bgScrollView.contentSize.height);
        //第一次添加数据的时候,添加y轴坐标
        for (int i = 0; i < 9; i++) {
            if (i == 8) {
                continue;
            }
            NSString *yTitle = self.barChartView.yArr[(8 - i)];
            UILabel *yLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headView.frame) + (i + 0.5) * self.frame.size.height * 0.8/10, 50, self.frame.size.height * 0.8/10)];
            [self addSubview:yLabel];
            yLabel.text = yTitle;
            yLabel.textAlignment = 2;
            yLabel.textColor = [UIColor lightGrayColor];
            yLabel.font = [UIFont systemFontOfSize:16];
            
            NSArray *percentArray = @[@"0",@"10",@"20",@"30",@"40",@"50",@"60",@"70",@"80"];
            NSString *yTitle1 = percentArray[(8 - i)];
            UILabel *yLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-50,CGRectGetMaxY(self.headView.frame) + (i + 0.5) * self.frame.size.height * 0.8/10, 50, self.frame.size.height * 0.8/10)];
            [self addSubview:yLabel1];
            yLabel1.text = yTitle1;
            yLabel1.textAlignment = 0;
            yLabel1.textColor = [UIColor lightGrayColor];
            yLabel1.font = [UIFont systemFontOfSize:16];
        }
}

- (void)setDataSource:(NSArray *)array1 array2:(NSArray *)array2 xArray:(NSArray *)xArray {
    _dataResource = array1;
    _dataResource2 = array2;
    _xArray = xArray;
    [self.barChartView setDataSource:array1 array2:array2 xArray:xArray];
    [self addBarChartView];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
