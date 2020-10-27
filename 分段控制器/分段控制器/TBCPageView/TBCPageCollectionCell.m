//
//  TBCPageCollectionCell.m
//  2222
//
//  Created by 韩李涛 on 2020/6/15.
//  Copyright © 2020 hlt. All rights reserved.
//

#import "TBCPageCollectionCell.h"
//#import "CategoryGroups.h"
//#import "CategoryItem.h"
@interface TBCPageCollectionCell()<UITableViewDelegate,UITableViewDataSource>{
    BOOL prepareRused;
}
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)UIScrollView *headView;
@property(nonatomic,strong)PageModule *item;
@end
@implementation TBCPageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.headView = [[UIScrollView alloc]init];
        [self addSubview:_headView];
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.contentView addSubview:tableView];
        _tableView = tableView;
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight =0;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc]init];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.tableView.frame = self.contentView.bounds;

}
- (void)sendItem:(PageModule *)module{
    _item = module;
    if (!module.listArray)return;
    self.dataArray = module.listArray;
    [_tableView setContentOffset:CGPointMake(0, module.offsety) animated:NO];
    [_tableView reloadData];
    
}
//- (void)setCategoryItem:(CategoryItem *)categoryItem{
//    _item = categoryItem;
   // self.dataArray = categoryItem.rows;

//    dispatch_async(dispatch_get_main_queue(), ^{
//        _tableView.mj_footer = nil;
//        _tableView.mj_header = nil;
//        if (_item.categorys.count>0) {
//            NSInteger indext = _item.infoIndex;
//            Categorynfos *info = _item.categorys[indext];
//            _item.offsety = info.offsety;
//        }
//  
//        [_tableView setContentOffset:CGPointMake(0, _item.offsety) animated:NO];
//    
//       
//        //热门不需要分页
//        if (![categoryItem.categoryId isEqualToString:@"hot"]) {
//            [MJRefreshManager AddMJRefreshGifFooter:_tableView  Target:self refreshingAction:@selector(getMoreData)];
//            [MJRefreshManager AddMJRefreshGifHeader:_tableView Target:self refreshingAction:@selector(getNewData)];
//            _tableView.mj_footer.hidden = (categoryItem.rows.count==0);
//            if(categoryItem.pageNumber>=categoryItem.totalpageSize&&categoryItem.totalpageSize!=-1) {
//          
//                    _tableView.mj_footer.hidden = YES;
//
//            }
//        }
//        if (categoryItem.totalpageSize!=-1&&categoryItem.rows.count==0) {
//            self.nodtaView.hidden = NO;
//            if (categoryItem.categorys.count>0) {
//                self.nodtaView.frame= CGRectMake(0, 54, ScreenWidth, ScreenHeight-54);
//            }else{
//                self.nodtaView.frame= CGRectMake(0, 0, ScreenWidth, ScreenHeight);
//            }
//        }else{
//            self.nodtaView.hidden = YES;
//            
//        }
//    });
//    [_tableView reloadData];
//}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    UICollectionView *collectionView = (UICollectionView *)self.superview;
    collectionView.scrollEnabled = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    UICollectionView *collectionView = (UICollectionView *)self.superview;
    collectionView.scrollEnabled = YES;
    if (decelerate) {
    }else{
        _item.offsety = scrollView.contentOffset.y;
      
    }
}
#pragma  mark - 拖拽减速后调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _item.offsety = scrollView.contentOffset.y;

//    NSInteger indext = _item.infoIndex;
//    if (_item.categorys.count>0) {
//        Categorynfos *info = _item.categorys[indext];
//        info.offsety = scrollView.contentOffset.y;
//    }
    
}
- (void)getNewData{
    if ([self.delegate respondsToSelector:@selector(loadNewData)]){
        [self.delegate loadNewData];
    }
}
- (void)getMoreData{
    if ([self.delegate respondsToSelector:@selector(loadMoreData)]) {
        [self.delegate loadMoreData];
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    return [self.delegate tableView:tableView heightForRowAtIndexPath:indexPath itemIndext:self.itemindex];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [self.delegate tableView:tableView tableViewForHeaderInSection:section itemIndext:self.itemindex];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self.delegate tableViewheightForHeaderInSection:section itemIndext:self.itemindex];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.delegate tableViewdidSelecttableView:tableView RowAtIndexPath:indexPath itemIndext:_itemindex];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
        return [self.delegate tableViewnumberOfRowsInSection:section itemIndext:_itemindex];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    return [self.delegate tableView:tableView cellForRowAtIndexPath:indexPath itemIndext:_itemindex];
}
@end
