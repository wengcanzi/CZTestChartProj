//
//  VMReportChartView.h
//  VehicleMonitoring
//
//  Created by cz on 2018/12/7.
//  Copyright © 2018年 ShenzhenRuiXunYiTong. All rights reserved.
//


#import <UIKit/UIKit.h>
#define BarChartBoxH self.frame.size.height / 8             //y轴单位长度
#define barChartColumnW      6   //柱宽
#define BarChartBoxW (self.frame.size.width) / ((self.dataResource.count >= 7 ?self.dataResource.count:7) + 1)   //柱状间隔

@interface VMReportChartView : UIView

//y轴刻度 传入数据源可得出结果
@property(nonatomic,strong) NSMutableArray *yArr;
@property(nonatomic,strong) NSArray *dataResource;
@property(nonatomic,strong) NSArray *dataResource2;
@property(nonatomic,strong) NSArray *dataResource3;
@property(nonatomic,strong) NSArray *xArray;

//- (UIColor *)colorWithIndex:(int)index;

- (void)setDataSource:(NSArray *)array1 array2:(NSArray *)array2 array3:(NSArray *)array3 xArray:(NSArray *)xArray type:(NSInteger)type;
- (void)getUnitFromType:(NSInteger )type;
@end
