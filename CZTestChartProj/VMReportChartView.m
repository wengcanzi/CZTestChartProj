//
//  VMReportChartView.m
//  VehicleMonitoring
//
//  Created by cz on 2018/12/7.
//  Copyright © 2018年 ShenzhenRuiXunYiTong. All rights reserved.
//

#import "VMReportChartView.h"
#import <CoreText/CoreText.h>
#import "VMTool.h"
#import "VMLineButton.h"
#import "VMReportShowValueLabel.h"

@interface VMReportChartView()

@property(nonatomic,assign) NSInteger type;

@property(nonatomic,strong) UILabel *showValueLabel;

@property(nonatomic,strong) VMReportShowValueLabel *valueLabel;

@end

@implementation VMReportChartView

- (NSMutableArray *)yArr {
    if(!_yArr){
        _yArr = [NSMutableArray array];
    }
    return _yArr;
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}



- (VMReportShowValueLabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[VMReportShowValueLabel alloc] initWithFrame:CGRectMake(0, 0, 90, 50)];
    }
    return _valueLabel;
}

- (UILabel *)showValueLabel {
    if (!_showValueLabel) {
        _showValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        _showValueLabel.textAlignment = 1;
        _showValueLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _showValueLabel.textColor = [UIColor whiteColor];
        _showValueLabel.layer.cornerRadius = 3;
        _showValueLabel.clipsToBounds = YES;
        _showValueLabel.font = [UIFont systemFontOfSize:12];
    }
    return _showValueLabel;
}

- (void)drawRect:(CGRect)rect {
    //创建画布
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    //绘制区域轴
    for (int i = 0 ; i < 7 ; i++) {
        [[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0]set];
        CGContextSetLineWidth(ctr, 0.5);
        //从左边6px开始画线
        CGContextMoveToPoint(ctr, 0, BarChartBoxH * (i + 1));
        if (self.frame.size.width < UIScreenWidth - 60) {
            CGContextAddLineToPoint(ctr, UIScreenWidth - 60, BarChartBoxH * (i + 1));
        }
        else {
            CGContextAddLineToPoint(ctr, self.frame.size.width, BarChartBoxH * (i + 1));
        }
        CGContextStrokePath(ctr);
    }
    
    for (int i = 0 ; i < self.dataResource.count ; i++) {
        NSString *unit = self.yArr[1];
        double unitValue = [unit doubleValue];
        double scale = 0.0;
        double scale2 = 0;

        NSString *valueString = self.dataResource2[i];
        scale = [valueString doubleValue]/unitValue;
        
        scale2 = [self.dataResource[i] doubleValue]/unitValue;
        
        [self drawMyRectWithCornerX:BarChartBoxW * (i+1) - barChartColumnW * 0.5 andY:BarChartBoxH * 7 andRadius:0 andWidth:barChartColumnW andHeight:(-scale) * BarChartBoxH andCtr:ctr andColor:[UIColor colorWithRed:208/255. green:75/255. blue:158/255. alpha:0.9] andHeight2:scale2*BarChartBoxH tag:i];

        NSAttributedString *monthString = [self getAttrStringWithString:self.xArray[i]];
        UILabel *label = [self viewWithTag:i+100000];
        if (!label) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(BarChartBoxW * (i+1) - (BarChartBoxH/2.), BarChartBoxH * 7.5 - BarChartBoxW/4., BarChartBoxH, BarChartBoxW/2)];;
            label.tag = i+100000;
            [self addSubview:label];
            label.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
        }
        label.attributedText = monthString;
    }
    [self addPointsWithCtr:ctr];
}


- (UIColor *)colorWithIndex:(int)index {
    return [UIColor colorWithRed:39/255. green:193/255. blue:255/255. alpha:1];
}

- (void)showButtonValue:(UIButton *)sender {
    CGPoint center = sender.center;
    
    self.valueLabel.center = CGPointMake(center.x, sender.frame.origin.y-15);
    [self addSubview:self.valueLabel];
    NSInteger i = sender.tag-100;
    NSString *valueText = self.dataResource3[i];
    self.valueLabel.text = [NSString stringWithFormat:@"%@", valueText];
}


- (void)showButtonValue1:(UIButton *)sender {
    CGPoint center = sender.center;
    
    self.valueLabel.center = CGPointMake(center.x, sender.frame.origin.y-25);
    [self addSubview:self.valueLabel];
    if (sender.tag >= 1100000) {
        NSString *valueText = self.dataResource[sender.tag-1100000];
        self.valueLabel.text = [NSString stringWithFormat:@"%@", valueText];
    }
    else {
        NSString *valueText = self.dataResource2[sender.tag-1000000];
        self.valueLabel.text = [NSString stringWithFormat:@"%@", valueText];
    }
    
}


/**
 *  绘制圆弧矩形
 *
 *  @param x      起始点的横坐标
 *  @param y      起始点的纵坐标
 *  @param radius 圆角弧形的半径
 *  @param width  矩形的宽度
 *  @param height 矩形的高度
 *  @param ctr    绘图上下文
 *  @param color  背景颜色
 */
- (void)drawMyRectWithCornerX:(CGFloat)x andY:(CGFloat)y andRadius:(CGFloat)radius andWidth:(CGFloat)width andHeight:(CGFloat)height andCtr:(CGContextRef)ctr andColor:(UIColor *)color andHeight2:(CGFloat)height2  tag:(NSInteger)tag{
    //第一部分
    [color set];
    CGContextMoveToPoint(ctr, x, y);
    CGContextAddLineToPoint(ctr, x, y - fabs(height) + radius);
    CGContextAddArc(ctr, x + width / 2, y - fabs(height) + radius, radius, - M_PI , 0, 0);
    CGContextAddLineToPoint(ctr, x + width,  y - fabs(height) + radius);
    CGContextAddLineToPoint(ctr, x + width, y);
    CGContextAddLineToPoint(ctr, x, y);
    CGContextFillPath(ctr);
    UIButton *control = [[UIButton alloc] initWithFrame:CGRectMake(x-12, y - fabs(height) + radius, 30, fabs(height))];
    [self addSubview:control];
    control.tag = tag+1000000;
    control.userInteractionEnabled = YES;
    [control addTarget:self action:@selector(showButtonValue1:) forControlEvents:UIControlEventTouchUpInside];

    //第二部分 //208 75 158
    [[UIColor colorWithRed:107/255. green:107/255. blue:201/255. alpha:0.9] set];
    CGFloat y2 = y + height;
    CGContextMoveToPoint(ctr, x, y2);
    CGContextAddLineToPoint(ctr, x, y2 - fabs(height2) + radius);
    CGContextAddArc(ctr, x + width / 2, y2 - fabs(height2) + radius, radius, - M_PI , 0, 0);
    CGContextAddLineToPoint(ctr, x + width,  y2 - fabs(height2) + radius);
    CGContextAddLineToPoint(ctr, x + width, y2);
    CGContextAddLineToPoint(ctr, x, y2);
    CGContextFillPath(ctr);
    UIButton *control2 = [[UIButton alloc] initWithFrame:CGRectMake(x-12, y2 - fabs(height2) + radius, 30, fabs(height2))];
    [self addSubview:control2];
    control2.tag = tag+1100000;
    control2.userInteractionEnabled = YES;
    [control2 addTarget:self action:@selector(showButtonValue1:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)addPointsWithCtr:(CGContextRef)ctr {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGContextSetLineWidth(ctr, 0.5);
    NSString *unit = self.yArr[1];
    double unitValue = [unit doubleValue];
    CGFloat height = CGRectGetHeight(self.frame);
    double value = [self.dataResource3[0] doubleValue];
    CGFloat pointY = height - (value/unitValue + 1) * BarChartBoxH;
    CGContextBeginPath(ctr);
    
    NSArray *array = self.dataResource3;
    
    //绘制区域轴
    for (int i = 0 ; i < _dataResource3.count; i++) {
        if (i == 0) {
            VMLineButton *pointButton = [self viewWithTag:i+100];
            if (!pointButton) {
                pointButton = [[VMLineButton alloc] init];
                pointButton.tag = i+100;
            }
            [pointButton addTarget:self action:@selector(showButtonValue:) forControlEvents:UIControlEventTouchUpInside];
            UIColor *pointColor = [UIColor colorWithRed:229/255. green:203/255. blue:56/255. alpha:0.9];
            
            [pointButton setBackgroundColor:pointColor];
            CGSize pSize = CGSizeMake(30, 30);
            
            pointButton.frame = CGRectMake(0, 0, pSize.width, pSize.height);
            pointButton.center = CGPointMake(BarChartBoxW - barChartColumnW * 0.5+3, pointY);
            pointButton.layer.cornerRadius = MIN(pSize.width, pSize.height)/2;
            pointButton.layer.masksToBounds = YES;
            pointButton.userInteractionEnabled = YES;
            [self addSubview:pointButton];
            [path moveToPoint:CGPointMake(BarChartBoxW - barChartColumnW * 0.5+3, pointY)];
        }
        else {
            CGFloat value1 = [array[i] floatValue];
            
            CGFloat pointY1 = height - (value1/unitValue + 1) * BarChartBoxH;
            
            VMLineButton *pointButton = [self viewWithTag:i+100];
            if (!pointButton) {
                pointButton = [[VMLineButton alloc] init];
                pointButton.tag = i+100;
            }
            [pointButton addTarget:self action:@selector(showButtonValue:) forControlEvents:UIControlEventTouchUpInside];
            
            
            UIColor *pointColor = [UIColor colorWithRed:229/255. green:203/255. blue:56/255. alpha:0.9];
            
            [pointButton setBackgroundColor:pointColor];
            CGSize pSize = CGSizeMake(30, 30);
            
            pointButton.frame = CGRectMake(0, 0, pSize.width, pSize.height);
            pointButton.center = CGPointMake(BarChartBoxW * (i+1) - barChartColumnW * 0.5+3, pointY1);
            pointButton.layer.cornerRadius = MIN(pSize.width, pSize.height)/2;
            pointButton.layer.masksToBounds = YES;
            pointButton.userInteractionEnabled = YES;
            [self addSubview:pointButton];
            
            [path addLineToPoint:CGPointMake(BarChartBoxW * (i+1) - barChartColumnW * 0.5+3, pointY1)];
            
            [[UIColor colorWithRed:229/255. green:203/255. blue:56/255. alpha:0.9] set];
            
            CGContextAddPath(ctr, path.CGPath);
            CGContextStrokePath(ctr);
        }
    }
}

- (long)maxValueWithDataResource:(NSArray *)dataArray {
    //获取最大值(因为柱子叠加，将两个数组相加)
    long maxValue = 0;
    for(int i = 1 ; i < dataArray.count; i++) {
        NSString *valueStr1 = _dataResource[i];
        NSString *valueStr2 = _dataResource2[i];

        long compareValue = [valueStr1 longLongValue] + [valueStr2 longLongValue];
        if(maxValue < compareValue) {
            maxValue = compareValue;
        }
    }
    return maxValue;
}

- (void)getUnitFromType:(NSInteger )type {
    
    long maxValue = [self maxValueWithDataResource:self.dataResource3];
    self.yArr = [NSMutableArray arrayWithArray:[VMTool getRangeArray:7 maxValue:maxValue]];
    return;
}

- (void)getUnitWithMaxValue:(int )maxValue {

}

- (void)setDataSource:(NSArray *)array1 array2:(NSArray *)array2 array3:(NSArray *)array3 xArray:(NSArray *)xArray type:(NSInteger)type {
    self.type = type;
    _dataResource = array1;
    _dataResource2 = array2;
    _dataResource3 = array3;
    _xArray = xArray;
    self.yArr = [NSMutableArray array];
    [self getUnitFromType:type];
    //先清空所有label的text
    for (UILabel *label in self.subviews) {
        [label removeFromSuperview];
    }
    for (UIButton *button in self.subviews) {
        [button removeFromSuperview];
    }
    [self setNeedsDisplay];
}

- (NSAttributedString *)getAttrStringWithString:(NSString *)originStr {
    NSString *newDate = originStr;
    if (newDate.length > 5) {
        newDate = [newDate substringFromIndex:5];
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:newDate];
    CFBooleanRef flag = kCFBooleanTrue;
    [str addAttribute:(id)kCTVerticalFormsAttributeName value:(__bridge id)flag range:NSMakeRange(0, [str length])];
    
    [str addAttribute:(id)NSForegroundColorAttributeName value:(id)[UIColor lightGrayColor] range:NSMakeRange(0, [str length])];
    [str addAttribute:(id)NSFontAttributeName value:(id)[UIFont systemFontOfSize:12] range:NSMakeRange(0, [str length])];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    [str addAttribute:(id)NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, [str length])];
    return str;
}

@end
