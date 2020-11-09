//
//  TBCPageView.m
//  2222
//
//  Created by 韩李涛 on 2020/6/15.
//  Copyright © 2020 hlt. All rights reserved.
//

#import "TBCPageView.h"
#import "TBCPageStyle.h"
#import "PageModule.h"
#import "TBCPageCollectionCell.h"
#import "UIView+Frame.h"
#import "MJRefresh.h"
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface TBCPageView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UIScrollView *titleView;

/** 标题下划线 */
@property (nonatomic, weak) UIView *titleUnderline;
/** 上一次点击的标题按钮 */
@property (nonatomic, weak) UIButton *previousClickedTitleButton;
@property(nonatomic,strong)TBCPageStyle *pagestyle;

@property(nonatomic,strong)NSMutableArray *moduleArray;
@end
@implementation TBCPageView
static  NSString  *tableViewcellId = @"tableViewcellId";
static  NSString  *viewcellId = @"viewcellId";
- (instancetype)initWithFrame:(CGRect)frame tities:(NSArray *)titles pageStyle:(TBCPageStyle *)pagestyle selectIndext:(NSInteger)indext{
    self = [super initWithFrame:frame];
    self.moduleArray = [NSMutableArray array];
    self.titleArray = titles;
    for (int i=0; i<self.titleArray.count; i++) {
        PageModule *item = [[PageModule  alloc]init];
        [self.moduleArray addObject:item];
    }
    if (self) {
        _pagestyle = pagestyle;
        UIScrollView *titelView = [[UIScrollView alloc]init];
        titelView.showsHorizontalScrollIndicator = NO;
       // titelView.scrollEnabled = pagestyle.titleViewScrollEnable;
        _titleView = titelView;
      //  titelView.contentInset = UIEdgeInsetsMake(0, 0, 0, pagestyle.scrollViewRightMargin);
        [self addSubview:titelView];
        _titleView.frame = CGRectMake(0, 0, frame.size.width,pagestyle.titleHeight);
        _titleView.backgroundColor = [UIColor whiteColor];
       // _titleView.backgroundColor = [UIColor redColor];
        [self setTitleViewWithTitles:titles pageStyle:pagestyle selectedIndext:indext];
        UIButton *firstButton = _titleView.subviews[indext];
        UIView *titleUnderline = [[UIView alloc] init];
        titleUnderline.backgroundColor =pagestyle.indicateViewColor;
        titleUnderline.frame  = CGRectMake(0, pagestyle.titleHeight-pagestyle.indicateViewHeight ,pagestyle.indicateViewWeight, pagestyle.indicateViewHeight);
        titleUnderline.centerX = firstButton.centerX;
        [self.titleView addSubview:titleUnderline];
        self.titleUnderline = titleUnderline;
        // 切换按钮状态
        firstButton.selected = YES;
        self.previousClickedTitleButton = firstButton;
        UIView *lineView = [[UIView alloc]init];
        [self addSubview:lineView];
        lineView.frame = CGRectMake(0, titelView.height-1, ScreenWidth, 1);
        lineView.backgroundColor = [UIColor greenColor];
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        flowlayout.minimumLineSpacing = 0.f;
        flowlayout.minimumInteritemSpacing = 0.f;
        flowlayout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,pagestyle.titleHeight, frame.size.width, frame.size.height-pagestyle.titleHeight) collectionViewLayout:flowlayout];
        collectionView.showsHorizontalScrollIndicator =NO;
        if (@available(iOS 11.0, *)) {
            collectionView.contentInsetAdjustmentBehavior=
            UIScrollViewContentInsetAdjustmentNever;
        } else {
           
        }
        [self addSubview:collectionView];
    
        collectionView.delegate = self;
        collectionView.backgroundColor =[UIColor clearColor];
        collectionView.bounces = NO;
        collectionView.dataSource = self;
        collectionView.pagingEnabled = YES;
        if (@available(iOS 10.0, *)) {
            collectionView.prefetchingEnabled =NO;
        }
        _collectionView = collectionView;
        [collectionView registerClass:[TBCPageCollectionCell class] forCellWithReuseIdentifier:tableViewcellId];
    }
    return self;
}


- (void)initTitleViewWithTitles:(NSArray <NSString *>*)titles selectedIndext:(NSInteger)indext{
    [self setTitleViewWithTitles:titles pageStyle:_pagestyle selectedIndext:indext];
}
- (void)setTitleViewWithTitles:(NSArray *)titles  pageStyle:(TBCPageStyle *)pagestyle selectedIndext:(NSInteger)indext{
    for (UIView *view in self.titleView.subviews) {
        [view removeFromSuperview];
    }
    self.titleArray = titles;
    CGFloat x =  pagestyle.titlesLeftMargin;
    CGFloat margin = pagestyle.titleMargin;
    for(int i=0;i<titles.count;i++) {
        UIButton *titleButton = [[UIButton alloc] init];
        titleButton.titleLabel.numberOfLines = 1;
        titleButton.titleLabel.lineBreakMode =NSLineBreakByTruncatingTail;
        titleButton.titleLabel.font = [UIFont systemFontOfSize:pagestyle.titleFont];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:titleButton];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        NSString *str = titles[i];
        CGFloat width = 0;
        if (pagestyle.titleWidth>0) {
            width= pagestyle.titleWidth;
        }else{
            width =   [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, pagestyle.titleHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:pagestyle.titleFont]} context:nil].size.width;
            if (width>100) {
                width = 100;
            }
        }
        titleButton.frame = CGRectMake(x, 0, width, pagestyle.titleHeight);
        x = x+margin+width;
        [titleButton  setTitle:str forState:UIControlStateNormal];
        if (i==titles.count-1) {
            _titleView.contentSize = CGSizeMake( CGRectGetMaxX(titleButton.frame), 0);
        }
       //[titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    }
    [self.titleView addSubview:self.titleUnderline];
    UIButton *firstButton = _titleView.subviews[indext];
    _titleUnderline.centerX = firstButton.centerX;
     _titleView.scrollEnabled = (_titleView.contentSize.width>ScreenWidth);
    [_collectionView reloadData];
}

- (void)reloadData{
    [_collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake(self.frame.size.width, self.frame.size.height-self.titleView.frame.size.height);
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PageModule *module = self.moduleArray[indexPath.item];
    UIView *view = [self.delegate  TBCPageViewContentViewForItemAtIndexPath:indexPath];
    view.tag =  indexPath.item;
    if ([view isKindOfClass:[UITableView class]]) {
        TBCPageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:tableViewcellId forIndexPath:indexPath];
        //[view removeObserver:self forKeyPath:@"contentOffset"];
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
            cell.tableView = nil;
        }
       
        UITableView *tableView = (UITableView *)view;
        [cell.contentView addSubview:tableView];
        cell.tableView = tableView;
        dispatch_async(dispatch_get_main_queue(), ^{
             [tableView setContentOffset:CGPointMake(0, module.offsety) animated:NO];
        });

        [tableView reloadData];
        return cell;
    }else{
        
        TBCPageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:viewcellId forIndexPath:indexPath];
        [cell.contentView.subviews performSelector:@selector(removeFromSuperview)];
        [cell.contentView addSubview:view];
        return cell;
        
    }
    
}

- (void)setTitleSeleteddindext:(NSInteger)indext{
    UIButton *btn = self.titleView.subviews[indext];
    [self titleButtonClick:btn];
}
//

#pragma mark - 监听
/**
 *  点击标题按钮
 */
- (void)titleButtonClick:(UIButton *)titleButton
{
    NSInteger previousIndext = self.previousClickedTitleButton.tag;
    PageModule *module = self.moduleArray[previousIndext];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:previousIndext inSection:0];
    TBCPageCollectionCell *cell =(TBCPageCollectionCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    module.offsety = cell.tableView.contentOffset.y;
    // 重复点击了标题按钮
   if (self.previousClickedTitleButton == titleButton&&titleButton.tag>0)return;
    NSUInteger index = titleButton.tag;
    if ([self.delegate respondsToSelector:@selector(titleViewSeleced:)]) {
        [self.delegate titleViewSeleced:index];
    }
    // 切换按钮状态
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    //居中显示
    [self adjustTitlelocation:index];
    
     [UIView animateWithDuration:0.25 animations:^{

          self.titleUnderline.centerX = titleButton.centerX;
         
       
     } completion:^(BOOL finished) {
         
     }];
  
    [self.collectionView setContentOffset:CGPointMake(index*ScreenWidth, 0) animated:NO];
    
}

- (void)adjustTitlelocation:(NSInteger)index{
    if (_titleView.scrollEnabled) {
        CGFloat width = self.collectionView.frame.size.width;
           // 让对应的顶部标题居中显示
             UIButton *btn = self.titleView.subviews[index];
             CGPoint titleOffset = self.titleView.contentOffset;
             titleOffset.x = btn.center.x - width * 0.5;
             // 左边超出处理
             if (titleOffset.x < 0) titleOffset.x = 0;
             // 右边超出处理
             CGFloat maxTitleOffsetX = self.titleView.contentSize.width+34- width;
             if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
             [self.titleView setContentOffset:titleOffset animated:YES];
       }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGFloat width = scrollView.frame.size.width;
    CGFloat offsetX = scrollView.contentOffset.x;
    // 当前位置需要显示的控制器的索引
    NSInteger index = offsetX / width;
    UIButton *btn = self.titleView.subviews[index];
    [self titleButtonClick:btn];
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (NSInteger)getModuleIndextWithContentView:(UIView *)view{
            
    return view.tag;
}

- (TBCPageCollectionCell*)cellWithtableView:(UITableView *)tableView{
    return (TBCPageCollectionCell*)tableView.superview.superview;
}


@end
