//
//  CZTestViewController.m
//  CZTestChartProj
//
//  Created by cz on 2019/5/4.
//  Copyright © 2019 anjubao. All rights reserved.
//

#import "CZTestViewController.h"
#import "VMChartTwoSideView.h"
#import "VMReportChartBgView.h"

@interface CZTestViewController ()

@end

@implementation CZTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    if (!self.type) {
        VMChartTwoSideView *chart = [[VMChartTwoSideView alloc] initWithFrame:self.view.bounds];
        NSMutableArray *dataArray = @[@"20",@"26",@"30",@"34",@"29",@"50",@"61",@"74",@"89",@"106"].mutableCopy;

        NSMutableArray *dataArray2 = @[@"40",@"46",@"50",@"54",@"49",@"70",@"81",@"94",@"109",@"126"].mutableCopy;
        NSMutableArray *xArray = @[@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"].mutableCopy;
        
        [chart setDataSource:dataArray array2:dataArray2 xArray:xArray];
        [self.view addSubview:chart];
    }
    else {
        VMReportChartBgView *chart = [[VMReportChartBgView alloc] initWithFrame:CGRectMake(0, 150, CGRectGetWidth(self.view.frame), 400)];
        NSMutableArray *dataArray = @[@"10",@"25",@"30",@"45",@"55",@"80",@"90",@"101",@"120"].mutableCopy;
        NSMutableArray *dataArray2 = @[@"15",@"30",@"40",@"60",@"70",@"90",@"100",@"110",@"130"].mutableCopy;
        NSMutableArray *dataArray3 = @[@"50",@"60",@"40",@"60",@"80",@"70",@"90",@"110",@"120"].mutableCopy;
        NSMutableArray *xArray = @[@"11-11",@"11-12",@"11-13",@"11-14",@"11-15",@"11-16",@"11-17",@"11-18",@"11-19"].mutableCopy;
        
        [chart setDataSource:dataArray array2:dataArray2 array3:dataArray3 xArray:xArray type:0];
        [self.view addSubview:chart];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
