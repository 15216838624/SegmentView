//
//  TBCPageCollectionCell.h
//  2222
//
//  Created by 韩李涛 on 2020/6/15.
//  Copyright © 2020 hlt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"PageModule.h"
NS_ASSUME_NONNULL_BEGIN
@class CategoryItem;
@interface TBCPageCollectionCell : UICollectionViewCell

@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,assign)NSInteger itemindex;
@property(nonatomic,strong)CategoryItem *categoryItem ;
- (void)sendItem:(PageModule *)module;
@end

NS_ASSUME_NONNULL_END
