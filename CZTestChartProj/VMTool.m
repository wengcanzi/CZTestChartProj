//
//  VMTool.m
//  CZTestChartProj
//
//  Created by 灿资 on 2019/5/4.
//  Copyright © 2019 anjubao. All rights reserved.
//

#import "VMTool.h"

@implementation VMTool

+ (NSArray *)getRangeArray:(NSInteger)count maxValue:(long)maxValue {
    //基数
    //    NSArray *unitValueArray = @[@"1",@"5",@"10",@"50",@"100",@"500",@"1000",@"5000",@"10000",@"50000",@"100000",@"500000",@"1000000",@"5000000",@"10000000",@"50000000",@"100000000",@"500000000"];
    
    NSMutableArray *valueArray = [NSMutableArray array];
    //
    for (int i = 0; i < 10; i++) {
        for (int j = 1; j < 10; j++) {
            long value = j * (pow(10, i));
            [valueArray addObject:[NSString stringWithFormat:@"%ld", value]];
        }
    }
    NSArray *unitValueArray = [NSArray arrayWithArray:valueArray];
    
    NSInteger index = 0; //基数坐标
    for (int i = 0; i < unitValueArray.count; i++) {
        
        if ((count-1) * [unitValueArray[i] integerValue] >= maxValue) {
            index = i;
            break;
        }
        
    }
    
    //y轴刻度
    NSMutableArray *yValue = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i++) {
        [yValue addObject:[NSString stringWithFormat:@"%lld", i * [unitValueArray[index] longLongValue]]];
    }
    
    
    return [NSArray arrayWithArray:yValue];
}


@end
