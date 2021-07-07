//
//  SegmentPageView.h
//  2222
//
//  Created by 韩李涛 on 2020/6/15.
//  Copyright © 2020 hlt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageModule.h"
//#import "PageModuleProtocol.h"
NS_ASSUME_NONNULL_BEGIN
@class SegmentPageStyle;
@class SegmentPageCollectionCell;
@protocol SegmentPageViewDelegate <NSObject>
@optional

- (UIView *)SegmentPageViewContentViewForItemAtIndexPath:(NSIndexPath *)indexPath;

- (NSArray<UIViewController *> *)SegmentPageViewChildViewControllers;

@optional


- (void)titleViewSeleced:(NSInteger)indext;


@end


@interface SegmentPageView : UIView
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSArray * _Nullable titleArray;
@property(nonatomic,weak)id<SegmentPageViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame tities:(NSArray<NSString *>*)titles pageStyle:(SegmentPageStyle *)pagestyle selectIndext:(NSInteger)indext;
- (void)initTitleViewWithTitles:(NSArray <NSString *>*)titles selectedIndext:(NSInteger)indext;
- (void)setTitleSeleteddindext:(NSInteger)indext;
- (void)reloadData;

@end




NS_ASSUME_NONNULL_END

