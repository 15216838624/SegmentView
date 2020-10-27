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
@protocol TTBCPageCollectionCellDelegate<NSObject>
@required
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath itemIndext:(NSInteger)itemIndext;

- (NSInteger)tableViewnumberOfRowsInSection:(NSInteger)section itemIndext:(NSInteger)itemIndext;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath itemIndext:(NSInteger)itemIndext;

- (UIView *)tableView:(UITableView *)tableView tableViewForHeaderInSection:(NSInteger)section itemIndext:(NSInteger)itemIndext;

- (CGFloat)tableViewheightForHeaderInSection:(NSInteger)section itemIndext:(NSInteger)itemIndext;
- (void)tableViewdidSelecttableView:(UITableView *)tableView RowAtIndexPath:(NSIndexPath *)indexPath itemIndext:(NSInteger)itemIndext;
- (void)loadNewData;
- (void)loadMoreData;
@end
@class CategoryItem;
@interface TBCPageCollectionCell : UICollectionViewCell
@property(nonatomic,weak)id<TTBCPageCollectionCellDelegate>delegate;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,assign)NSInteger itemindex;
@property(nonatomic,strong)CategoryItem *categoryItem ;
//@property(nonatomic,strong)NoDataView*nodtaView;
- (void)sendItem:(PageModule *)module;
@end

NS_ASSUME_NONNULL_END
