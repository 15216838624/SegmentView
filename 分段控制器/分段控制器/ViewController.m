//
//  ViewController.m
//  分段控制器
//
//  Created by 韩李涛 on 2020/10/23.
//

#import "ViewController.h"
#import "MyItem.h"
#import "TBCPageView.h"
#import <WebKit/WebKit.h>
#import"TBCPageStyle.h"
@interface ViewController ()<TBCPageViewDelegate,WKNavigationDelegate>
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,strong)TBCPageView *pageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.array = [NSMutableArray array];
    CGFloat y =  0;
    TBCPageStyle *pageStyle = [[TBCPageStyle alloc]init];
    pageStyle.titleViewScrollEnable = YES;
    pageStyle.scrollViewRightMargin = 0;
    TBCPageView *pageView =[[TBCPageView alloc]initWithFrame:CGRectMake(0, y, 375, 667) tities:@[@"你好",@"我的",@"他的"] pageStyle:pageStyle selectIndext:0];
    pageView.delegate = self;
    self.pageView = pageView;
    [self.view addSubview:pageView];
    [self getRequestData];
}

- (void)getRequestData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"延迟3s后执行");
        NSMutableArray *array = [NSMutableArray array];
        for (int i=0; i<30; i++) {
            MyItem *item = [[MyItem alloc]init];
            item.name = [NSString stringWithFormat:@"%@-测试-%d",@"a",i];
            [array addObject:item];
        }
        
        [self.pageView refreshDataWithArray:array inIndext:0];
        
        
        NSMutableArray *array1 = [NSMutableArray array];
        for (int i=0; i<23; i++) {
            MyItem *item = [[MyItem alloc]init];
            item.name = [NSString stringWithFormat:@"%@-测试-%d",@"b",i];
            [array1 addObject:item];
        }
        [self.pageView refreshDataWithArray:array1 inIndext:1];
        
        
        NSMutableArray *array2 = [NSMutableArray array];
        for (int i=0; i<43; i++) {
            MyItem *item = [[MyItem alloc]init];
            item.name = [NSString stringWithFormat:@"%@-测试-%d",@"c",i];
            [array2 addObject:item];
        }
        [self.pageView refreshDataWithArray:array2 inIndext:2];
    });
 
}

- (void)titleViewSeleced:(NSInteger)indext{
    
    
}
- (NSInteger)tableViewnumberOfRowsInSection:(NSInteger)section moduleIndext:(NSInteger)moduleIndext{
    NSArray *array = [self.pageView getDataFromListWithIndext:moduleIndext];
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath moduleIndext:(NSInteger)moduleIndext{
  
    static NSString *cellName = @"CmsTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil)
    {
        cell =  [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    if (moduleIndext==0) {
        cell.contentView.backgroundColor = [UIColor redColor];
    }
    if (moduleIndext==1) {
        cell.contentView.backgroundColor = [UIColor greenColor];
    }
    if (moduleIndext==2) {
        cell.contentView.backgroundColor = [UIColor yellowColor];
    }
    NSArray *array = [self.pageView getDataFromListWithIndext:moduleIndext];
    if (array.count>0) {
        MyItem *item = array[indexPath.item];
        cell.textLabel.text = item.name;
    }
  
    return cell;
}
@end
