//
//  TBCPageStyle.h
//  分段控制器
//
//  Created by 韩李涛 on 2020/10/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface TBCPageStyle : NSObject
@property(nonatomic,assign)CGFloat indicateViewHeight;
@property(nonatomic,assign)CGFloat indicateViewWeight;
@property(nonatomic,strong)UIColor *indicateViewColor;
@property(nonatomic,assign)CGFloat  titleMargin;
@property(nonatomic,assign)CGFloat titleHeight;
@property(nonatomic,assign)CGFloat  titlesLeftMargin;
@property(nonatomic,assign)CGFloat titleFont;
@property(nonatomic,assign)BOOL titleViewScrollEnable;
@property(nonatomic,assign)CGFloat titleWidth;
@property(nonatomic,assign)CGFloat scrollViewRightMargin;
@end

NS_ASSUME_NONNULL_END
