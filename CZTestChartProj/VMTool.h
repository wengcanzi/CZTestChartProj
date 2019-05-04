//
//  VMTool.h
//  CZTestChartProj
//
//  Created by 灿资 on 2019/5/4.
//  Copyright © 2019 anjubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#define UIScreenWidth [UIScreen mainScreen].bounds.size.width
 #define UIScreenHeight [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface VMTool : NSObject

//y轴坐标范围
+ (NSArray *)getRangeArray:(NSInteger)count maxValue:(long)maxValue;

@end

NS_ASSUME_NONNULL_END
