//
//  PageModule.h
//  分段控制器
//
//  Created by 韩李涛 on 2020/10/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface PageModule : NSObject
@property(nonatomic,strong,readwrite)NSArray *listArray;
@property(nonatomic,assign,readwrite)CGFloat offsety;
@end

NS_ASSUME_NONNULL_END
