//
//  VMBarChartView.m
//  CZChartProJ
//
//  Created by cz on 2018/11/1.
//  Copyright © 2018年 ShenzhenRuiXunYiTong. All rights reserved.
//

#import "VMBarChartView.h"
#import <CoreText/CoreText.h>
#import "VMTool.h"

@interface VMBarChartView()

@property(nonatomic,copy) NSString *yUnit;

@property(nonatomic,assign) int level;

@property(nonatomic,copy) NSString *type;

@property(nonatomic,strong) UILabel *showValueLabel;

@end


@implementation VMBarChartView

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


- (UILabel *)showValueLabel {
    if (!_showValueLabel) {
        _showValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
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
    for (int i = 0 ; i < self.xArray.count ; i++) {
        //绘制X轴坐标
        NSString *moneyStr = self.xArray[i];
        
        NSAttributedString *monthString = [self getAttrStringWithString:moneyStr];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(BarChartBoxW * (i+0.5) - (30), BarChartBoxH * 9+10, 60, BarChartBoxW/2)];;
        [self addSubview:label];
        label.attributedText = monthString;
        label.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
    }
    [self addPointsWithCtr:ctr];
    //绘制区域轴
    for (int i = 0 ; i < 9 ; i++) {
        if (i == 8) {
            continue;
        }
        [[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0]set];
        CGContextSetLineWidth(ctr, 0.5);
        //从左边6px开始画线
        CGContextMoveToPoint(ctr, 0, BarChartBoxH * (i + 1));
        CGContextAddLineToPoint(ctr, self.frame.size.width, BarChartBoxH * (i + 1));
        CGContextStrokePath(ctr);
    }
    
}


- (UIColor *)colorWithIndex:(int)index {
    return [UIColor colorWithRed:39/255. green:193/255. blue:255/255. alpha:1];
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
- (void)drawMyRectWithCornerX:(CGFloat)x andY:(CGFloat)y andRadius:(CGFloat)radius andWidth:(CGFloat)width andHeight:(CGFloat)height andCtr:(CGContextRef)ctr andColor:(UIColor *)color {
    //第一部分
    [color set];
    CGContextMoveToPoint(ctr, x, y);
    CGContextAddLineToPoint(ctr, x, y - fabs(height) + radius);
    CGContextAddArc(ctr, x + width / 2, y - fabs(height) + radius, radius, - M_PI , 0, 0);
    CGContextAddLineToPoint(ctr, x + width,  y - fabs(height) + radius);
    CGContextAddLineToPoint(ctr, x + width, y);
    CGContextAddLineToPoint(ctr, x, y);
    CGContextFillPath(ctr);
    //第二部分
    [[UIColor greenColor] set];
    CGFloat height2 = 50/25*BarChartBoxH;
    CGFloat y2 = y + height;
    CGContextMoveToPoint(ctr, x, y2);
    CGContextAddLineToPoint(ctr, x, y2 - fabs(height2) + radius);
    CGContextAddArc(ctr, x + width / 2, y2 - fabs(height2) + radius, radius, - M_PI , 0, 0);
    CGContextAddLineToPoint(ctr, x + width,  y2 - fabs(height2) + radius);
    CGContextAddLineToPoint(ctr, x + width, y2);
    CGContextAddLineToPoint(ctr, x, y2);
    CGContextFillPath(ctr);
}

- (void)addPointsWithCtr:(CGContextRef)ctr {
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat value = 20;
    CGFloat unitValue = [_yArr[1] integerValue];
    CGFloat pointY = height - (value/unitValue + 1) * BarChartBoxH;
    
    //曲线1
    NSArray *array = self.dataResource;
    
    //曲线2
    NSArray *array2 = self.dataResource2;    
    //上面的曲线
    UIBezierPath *path2 = [[UIBezierPath alloc] init];
    CGContextSetLineWidth(ctr, 0.5);
    CGContextSetStrokeColorWithColor(ctr, [UIColor colorWithRed:145/255. green:141/255. blue:166/266. alpha:1].CGColor);
    CGFloat height2 = CGRectGetHeight(self.frame);
    CGFloat value2 = 40;
    CGFloat pointY2 = height2 - (value2/unitValue + 1) * BarChartBoxH;
    
    //绘制区域轴
    for (int i = 0 ; i < array2.count; i++) {
        if (i == 0) {
            UIButton *pointButton = [[UIButton alloc] init];
            pointButton.tag = i;
            UIColor *pointColor = [UIColor colorWithRed:108/255. green:102/255. blue:169/255. alpha:1];
            
            [pointButton setBackgroundColor:pointColor];
            CGSize pSize = CGSizeMake(4, 4);
            
            pointButton.frame = CGRectMake(0, 0, pSize.width, pSize.height);
            pointButton.center = CGPointMake(BarChartBoxW/2., pointY2);
            pointButton.layer.cornerRadius = MIN(pSize.width, pSize.height)/2;
            pointButton.layer.masksToBounds = YES;
            pointButton.userInteractionEnabled = YES;
            [self addSubview:pointButton];
            [path2 moveToPoint:CGPointMake(BarChartBoxW/2., pointY2)];
        }
        else {
            CGFloat value1 = [array2[i] floatValue];
            CGFloat pointY1 = height - (value1/unitValue + 1) * BarChartBoxH;
            
            UIButton *pointButton = [[UIButton alloc] init];
            pointButton.tag = i;
            UIColor *pointColor = [UIColor colorWithRed:108/255. green:102/255. blue:169/255. alpha:1];
            
            [pointButton setBackgroundColor:pointColor];
            CGSize pSize = CGSizeMake(4, 4);
            
            pointButton.frame = CGRectMake(0, 0, pSize.width, pSize.height);
            pointButton.center = CGPointMake(BarChartBoxW * (i+0.5), pointY1);
            pointButton.layer.cornerRadius = MIN(pSize.width, pSize.height)/2;
            pointButton.layer.masksToBounds = YES;
            pointButton.userInteractionEnabled = YES;
            [self addSubview:pointButton];
            
            CGFloat value0 = [array2[i-1] floatValue];
            CGFloat pointY0 = height - (value0/unitValue + 1) * BarChartBoxH;
            
            //上一个点的x坐标
            CGFloat lastPointX = BarChartBoxW * (i+0.5);
            //上一个点的y坐标
            CGFloat lastPointY = pointY1;
            //该柱子顶部中点的x坐标
            CGFloat pointX = BarChartBoxW * (i-1+0.5);
            
            //添加曲线 两个控制点 x为两个点的中间点 y为首末点的y坐标 为了实现平滑连接
            BOOL isUp = !(i%2);
            [path2 addQuadCurveToPoint:CGPointMake(lastPointX, lastPointY) controlPoint:CGPointMake((lastPointX+pointX)/2., isUp ? fminf(lastPointY, pointY0)-8 : fmaxf(lastPointY, pointY0)+8)];
        }
    }
    
    //    连接上第一条线，从最后一个点开始
    for (int i = 9 ; i >= 0; i--) {
        if (i == 0) {
            [path2 moveToPoint:CGPointMake(BarChartBoxW/2., pointY)];
        }
        else {
            
            CGFloat value1 = [array[i] floatValue];
            CGFloat pointY1 = height - (value1/unitValue + 1) * BarChartBoxH;
            
            if (i == 9) {
                [path2 addLineToPoint:CGPointMake(BarChartBoxW * (i+0.5), pointY1)];
            }
            CGFloat value0 = [array[i-1] floatValue];
            CGFloat lastPointY = height - (value0/unitValue + 1) * BarChartBoxH;
            
            //曲线
            //上一个点的x坐标
            CGFloat pointX = BarChartBoxW * (i+0.5);
            //上一个点的y坐标
            CGFloat pointY0 = pointY1;
            //该柱子顶部中点的x坐标
            CGFloat lastPointX = BarChartBoxW * (i-1+0.5);
            //该柱子顶部中点的y坐标
            BOOL isUp = !(i%2);
            [path2 addQuadCurveToPoint:CGPointMake(lastPointX, lastPointY) controlPoint:CGPointMake((lastPointX+pointX)/2., isUp ? fminf(lastPointY, pointY0)-8 : fmaxf(lastPointY, pointY0)+8)];
        }
    }
    
    CGContextAddPath(ctr, path2.CGPath);
    CGContextSetRGBFillColor(ctr, 200/255., 199/255., 228/255., 0.95);
    //填充颜色加边框
    CGContextDrawPath(ctr, kCGPathFillStroke);
    
    
    //下面的曲线
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGContextSetLineWidth(ctr, 0.5);
    CGContextSetStrokeColorWithColor(ctr, [UIColor colorWithRed:161/255. green:138/255. blue:186/266. alpha:1].CGColor);
    //绘制区域轴
    for (int i = 0 ; i < array.count; i++) {
        if (i == 0) {
            UIButton *pointButton = [[UIButton alloc] init];
            pointButton.tag = i;
            UIColor *pointColor = [UIColor colorWithRed:184/255. green:126/255. blue:186/255. alpha:1];
            
            [pointButton setBackgroundColor:pointColor];
            CGSize pSize = CGSizeMake(4, 4);
            
            pointButton.frame = CGRectMake(0, 0, pSize.width, pSize.height);
            pointButton.center = CGPointMake(BarChartBoxW/2., pointY);
            pointButton.layer.cornerRadius = MIN(pSize.width, pSize.height)/2;
            pointButton.layer.masksToBounds = YES;
            pointButton.userInteractionEnabled = YES;
            [self addSubview:pointButton];
            [path moveToPoint:CGPointMake(BarChartBoxW/2., pointY)];
        }
        else {
            CGFloat value1 = [array[i] floatValue];
            CGFloat pointY1 = height - (value1/unitValue + 1) * BarChartBoxH;
            
            UIButton *pointButton = [[UIButton alloc] init];
            pointButton.tag = i;
            UIColor *pointColor = [UIColor colorWithRed:184/255. green:126/255. blue:186/255. alpha:1];
            
            [pointButton setBackgroundColor:pointColor];
            CGSize pSize = CGSizeMake(4, 4);
            
            pointButton.frame = CGRectMake(0, 0, pSize.width, pSize.height);
            pointButton.center = CGPointMake(BarChartBoxW * (i+0.5), pointY1);
            pointButton.layer.cornerRadius = MIN(pSize.width, pSize.height)/2;
            pointButton.layer.masksToBounds = YES;
            pointButton.userInteractionEnabled = YES;
            [self addSubview:pointButton];
            //曲线
            CGFloat value0 = [array[i-1] floatValue];
            CGFloat pointY0 = height - (value0/unitValue + 1) * BarChartBoxH;
            
            //上一个点的x坐标
            CGFloat lastPointX = BarChartBoxW * (i+0.5);
            //上一个点的y坐标
            CGFloat lastPointY = pointY1;
            //该柱子顶部中点的x坐标
            CGFloat pointX = BarChartBoxW * (i-1+0.5);
            //添加曲线 两个控制点 x为两个点的中间点 y为首末点的y坐标 为了实现平滑连接
            BOOL isUp = !(i%2);
            [path addQuadCurveToPoint:CGPointMake(lastPointX, lastPointY) controlPoint:CGPointMake((lastPointX+pointX)/2., isUp ? fminf(lastPointY, pointY0)-8 : fmaxf(lastPointY, pointY0)+8)];
        }
    }
    //添加首尾两点连接,填充颜色 CGRectGetHeight(self.frame) BarChartBoxH * 8.5 首尾坐标10 106
    CGFloat x1 = BarChartBoxW * (array.count-1+0.5);
    [path addLineToPoint:CGPointMake(x1, BarChartBoxH * 8.5)];
    CGFloat x2 = BarChartBoxW/2.;
    [path addLineToPoint:CGPointMake(x2, BarChartBoxH * 8.5)];
    
    CGContextAddPath(ctr, path.CGPath);
    CGContextSetRGBFillColor(ctr, 198/255., 158/255., 212/255., 0.95);
    //填充颜色,加边框
    CGContextDrawPath(ctr, kCGPathFillStroke);
}

- (void)getYDataArrWithDataResource:(NSArray *)dataResource {
    //获取最大值
    CGFloat maxValue = [self maxValueWithDataResource:dataResource];
    
    //获取刻度值
}

- (CGFloat)maxValueWithDataResource:(NSArray *)dataResource {
    //获取最大值
    CGFloat maxValue = [self.dataResource[0] floatValue];
    
    for(int i = 1 ; i < dataResource.count ; i++) {
        CGFloat compareValue = [self.dataResource[i] floatValue];
        if(maxValue < compareValue) {
            maxValue = compareValue;
        }
    }
    
    return maxValue;
    
}

- (NSAttributedString *)getAttrStringWithString:(NSString *)originStr {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:originStr];
    CFBooleanRef flag = kCFBooleanTrue;
    [str addAttribute:(id)kCTVerticalFormsAttributeName value:(__bridge id)flag range:NSMakeRange(0, [str length])];
    
    [str addAttribute:(id)NSForegroundColorAttributeName value:(id)[UIColor lightGrayColor] range:NSMakeRange(0, [str length])];
    [str addAttribute:(id)NSFontAttributeName value:(id)[UIFont systemFontOfSize:14] range:NSMakeRange(0, [str length])];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentLeft;
    [str addAttribute:(id)NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, [str length])];

    
    return str;
}

- (void)getUnitFromType:(NSInteger )type {
    
    long maxValue = [self maxValueWithDataResource:self.dataResource];
    self.yArr = [NSMutableArray arrayWithArray:[VMTool getRangeArray:9 maxValue:maxValue]];
    return;
}


- (void)setDataSource:(NSArray *)array1 array2:(NSArray *)array2 xArray:(NSArray *)xArray {
    _dataResource = array1;
    _dataResource2 = array2;
    _xArray = xArray;
    self.yArr = [NSMutableArray array];
    [self getUnitFromType:0];
    [self setNeedsDisplay];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
