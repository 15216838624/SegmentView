//
//  SegmentPageStyle.m
//  分段控制器
//
//  Created by 韩李涛 on 2020/10/23.
//

#import "SegmentPageStyle.h"

@implementation SegmentPageStyle
- (instancetype)init{
    if (self = [super init]) {
        self.titleHeight = 50;
        self.titleMargin = 20;
        self.titlesLeftMargin = 15;
        self.titleFont =  14;
        self.indicateViewColor =  [UIColor redColor];
        self.indicateViewWeight = 30;
        self.indicateViewHeight = 3;
    }
    return self;
}
@end
