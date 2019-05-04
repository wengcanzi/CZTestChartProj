//
//  VMChartTwoSideView.h
//  CZChartProJ
//
//  Created by cz on 2018/11/1.
//  Copyright © 2018年 ShenzhenRuiXunYiTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VMBarChartView.h"

@interface VMChartTwoSideView : UIView

@property(nonatomic,strong) NSArray *dataResource;
@property(nonatomic,strong) NSArray *dataResource2;
@property(nonatomic,strong) NSArray *xArray;

- (void)setDataSource:(NSArray *)array1 array2:(NSArray *)array2 xArray:(NSArray *)xArray;
@end
