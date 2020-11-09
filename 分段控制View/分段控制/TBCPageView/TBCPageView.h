//
//  TBCPageView.h
//  2222
//
//  Created by 韩李涛 on 2020/6/15.
//  Copyright © 2020 hlt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageModule.h"
//#import "PageModuleProtocol.h"
NS_ASSUME_NONNULL_BEGIN
@class TBCPageStyle;
@class TBCPageCollectionCell;
@protocol TBCPageViewDelegate <NSObject>
@required
- (UIView *)TBCPageViewContentViewForItemAtIndexPath:(NSIndexPath *)indexPath;



@optional


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath moduleIndext:(NSInteger)moduleIndex;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath moduleIndext:(NSInteger)moduleIndex;

- (NSInteger)tableViewnumberOfRowsInSection:(NSInteger)section moduleIndext:(NSInteger)moduleIndext;

- (UIView *)tableView:(UITableView *)tableView tableViewForHeaderInSection:(NSInteger)section moduleIndext:(NSInteger)moduleIndext;

- (CGFloat)tableViewheightForHeaderInSection:(NSInteger)section moduleIndext:(NSInteger)moduleIndext;

- (void)tableViewdidSelecttableView:(UITableView *)tableView RowAtIndexPath:(NSIndexPath *)indexPath moduleIndext:(NSInteger)moduleIndext;

- (void)titleViewSeleced:(NSInteger)indext;


-(void)loadNewData:(void(^)(void))loadFinsh indext:(NSInteger)indext;
- (void)loadMoreData:(void(^)(void))loadFinsh indext:(NSInteger)indext;
@end


@interface TBCPageView : UIView
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSArray * _Nullable titleArray;
@property(nonatomic,weak)id<TBCPageViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame tities:(NSArray<NSString *>*)titles pageStyle:(TBCPageStyle *)pagestyle selectIndext:(NSInteger)indext;
- (void)initTitleViewWithTitles:(NSArray <NSString *>*)titles selectedIndext:(NSInteger)indext;
- (void)setTitleSeleteddindext:(NSInteger)indext;
- (void)reloadData;

- (NSInteger)getModuleIndextWithContentView:(UIView *)view;
@end




NS_ASSUME_NONNULL_END

