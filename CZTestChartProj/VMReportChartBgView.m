//
//  VMReportChartBgView.m
//  VehicleMonitoring
//
//  Created by cz on 2018/12/7.
//  Copyright © 2018年 ShenzhenRuiXunYiTong. All rights reserved.
//

#import "VMReportChartBgView.h"
#import "VMReportChartView.h"

@interface VMReportChartBgView ()

@property(nonatomic,strong) UIView *headView;

@property(nonatomic,strong) VMReportChartView *barChartView;

@property(nonatomic,strong) UIScrollView *bgScrollView;

@property(nonatomic,strong) UILabel *yUnitLabel; //x轴的时间单位

@end

@implementation VMReportChartBgView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        //head
        [self addHeadView];
    }
    return self;
}

- (void)addHeadView {
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.08)];
    self.headView = headView;
    [self addSubview:self.headView];
    
    //添加三个色块和标签
    CGFloat partWidth = (self.frame.size.width-40)/3.;
    UIView *colorV1 = [[UIView alloc] initWithFrame:CGRectMake(20 + partWidth/2-50, self.frame.size.height * 0.04-9, 28, 18)];
    colorV1.backgroundColor = [UIColor colorWithRed:107/255. green:107/255. blue:201/255. alpha:0.9];
    colorV1.layer.cornerRadius = 4;
    
    UIView *colorV2 = [[UIView alloc] initWithFrame:CGRectMake(20 + partWidth + partWidth/2-50, self.frame.size.height * 0.04-9, 28, 18)];
    colorV2.backgroundColor = [UIColor colorWithRed:208/255. green:75/255. blue:158/255. alpha:0.9];
    colorV2.layer.cornerRadius = 4;

    UIView *colorV3 = [[UIView alloc] initWithFrame:CGRectMake(20 + partWidth*2 + partWidth/2-50, self.frame.size.height * 0.04-9, 28, 18)];
    colorV3.backgroundColor = [UIColor colorWithRed:229/255. green:203/255. blue:56/255. alpha:0.9];
    colorV3.layer.cornerRadius = 4;

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(colorV1.frame)+10, 0, 60, self.frame.size.height * 0.08)];
//    label1.text = @"现金";
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor = [UIColor lightGrayColor];
    label1.tag = 10000;
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(colorV2.frame)+10, 0, 60, self.frame.size.height * 0.08)];
//    label2.text = @"卡收";
    label2.font = [UIFont systemFontOfSize:13];
    label2.textColor = [UIColor lightGrayColor];
    label2.tag = 10001;

    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(colorV3.frame)+10, 0, 60, self.frame.size.height * 0.08)];
    label3.font = [UIFont systemFontOfSize:13];
//    label3.text = @"总收入";
    label3.textColor = [UIColor lightGrayColor];
    label3.tag = 10002;

    [self.headView addSubview:colorV1];
    [self.headView addSubview:colorV2];
    [self.headView addSubview:colorV3];
    [self.headView addSubview:label1];
    [self.headView addSubview:label2];
    [self.headView addSubview:label3];
}

- (VMReportChartView *)barChartView {
    if (!_barChartView) {
        _barChartView = [[VMReportChartView alloc] init];
        [self.bgScrollView addSubview:_barChartView];
    }
    return _barChartView;
}

- (UILabel *)yUnitLabel {
    if (!_yUnitLabel) {
        _yUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame), 50, 30)];
        _yUnitLabel.textAlignment = 2;
        _yUnitLabel.textColor = [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0];
        _yUnitLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_yUnitLabel];
    }
    return _yUnitLabel;
}

- (UIScrollView *)bgScrollView {
    if (!_bgScrollView) {
        UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(self.headView.frame), self.frame.size.width-70, self.frame.size.height*0.9)];
        sv.showsVerticalScrollIndicator = NO;
        sv.showsHorizontalScrollIndicator = NO;
        [self addSubview:sv];
        _bgScrollView = sv;
    }
    return _bgScrollView;
}

- (void)addBarChartView {
    NSInteger count = self.dataResource.count >= 7?self.dataResource.count:7;
    CGFloat contentWidth = (self.frame.size.width - 60) / 7. * (count + 1);
    self.bgScrollView.contentSize = CGSizeMake(contentWidth, CGRectGetHeight(self.frame) * 0.75 );
    self.bgScrollView.contentOffset = CGPointZero;
    self.barChartView.frame = CGRectMake(0, 0, self.bgScrollView.contentSize.width, self.bgScrollView.contentSize.height);
//        self.barChartView.dataResource = self.dataResource;
        //第一次添加数据的时候,添加y轴坐标
    for (int i = 0; i < 7; i++) {
        UILabel *yLabel = [self viewWithTag:i+1000];
        NSString *yTitle = self.barChartView.yArr[(6 - i)];
        if (!yLabel) {
            yLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headView.frame) + (i + 0.5) * self.frame.size.height * 0.75/8, 50, self.frame.size.height * 0.75/8)];
            yLabel.tag = i+1000;
            yLabel.textAlignment = 2;
            yLabel.textColor = [UIColor lightGrayColor];
            yLabel.font = [UIFont systemFontOfSize:16];
            yLabel.numberOfLines = 2;
            [self addSubview:yLabel];
        }
        yLabel.text = yTitle;
    }
}

- (void)setDataSource:(NSArray *)array1 array2:(NSArray *)array2 array3:(NSArray *)array3 xArray:(NSArray *)xArray type:(NSInteger)type {
    _dataResource = array1;
    _dataResource2 = array2;
    _dataResource3 = array3;
    [self.barChartView setDataSource:array1 array2:array2 array3:array3 xArray:xArray type:type];
    [self addBarChartView];

    [self bringSubviewToFront:self.yUnitLabel];
    if (type == 0) {
        self.yUnitLabel.text = @"(KM)";
    }
    else if (type == 1) {
        self.yUnitLabel.text = @"(次)";
        
    }
    else if (type == 2) {
        self.yUnitLabel.text = @"(元)";
        
    }
}

- (void)setTitleArray:(NSArray *)titles {
    
    for (int i = 0; i < titles.count; i++) {
        UILabel *label = [self.headView viewWithTag:10000+i];
        if (label) {
            label.text = titles[i];
        }
    }
}

@end
