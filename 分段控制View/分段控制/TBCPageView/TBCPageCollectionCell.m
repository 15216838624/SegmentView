//
//  TBCPageCollectionCell.m
//  2222
//
//  Created by 韩李涛 on 2020/6/15.
//  Copyright © 2020 hlt. All rights reserved.
//

#import "TBCPageCollectionCell.h"

@interface TBCPageCollectionCell(){
    BOOL prepareRused;
}

@end
@implementation TBCPageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    

    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.tableView.frame = self.contentView.bounds;

}




@end
