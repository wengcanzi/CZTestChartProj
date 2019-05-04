//
//  VMReportChartBgView.h
//  VehicleMonitoring
//
//  Created by cz on 2018/12/7.
//  Copyright © 2018年 ShenzhenRuiXunYiTong. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VMReportChartBgView : UIView

//y轴刻度 传入数据源可得出结果
@property(nonatomic,strong) NSArray *dataResource;
@property(nonatomic,strong) NSArray *dataResource2;
@property(nonatomic,strong) NSArray *dataResource3;

//三组数据源(还有一组时间x轴)

- (void)setDataSource:(NSArray *)array1 array2:(NSArray *)array2 array3:(NSArray *)array3 xArray:(NSArray *)xArray type:(NSInteger)type;

//- (void)setTitleArray:(NSArray *)titles;

@end
