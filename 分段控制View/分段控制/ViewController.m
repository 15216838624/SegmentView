//
//  ViewController.m
//  分段控制器
//
//  Created by 韩李涛 on 2020/10/23.
//

#import "ViewController.h"
#import "MyItem.h"
#import "SegmentPageView.h"
#import <WebKit/WebKit.h>
#import"SegmentPageStyle.h"
#import "TestViewController.h"
#import "SegmentPageCell.h"
@interface ViewController ()<SegmentPageViewDelegate,WKNavigationDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *array1;
@property(nonatomic,strong)NSMutableArray *array2;
@property(nonatomic,strong)NSMutableArray *array3;
@property(nonatomic,strong)SegmentPageView *pageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    self.array1 = [NSMutableArray array];
    self.array2 = [NSMutableArray array];
    self.array3 = [NSMutableArray array];
    CGFloat y =  88;
    SegmentPageStyle *pageStyle = [[SegmentPageStyle alloc]init];
    pageStyle.titleViewScrollEnable = YES;
    pageStyle.scrollViewRightMargin = 0;
    SegmentPageView *pageView =[[SegmentPageView alloc]initWithFrame:CGRectMake(0, y, 375, 667) tities:@[@"你好",@"我的"] pageStyle:pageStyle selectIndext:0];
    pageView.delegate = self;
    self.pageView = pageView;
    [self.view addSubview:pageView];
    [self getRequestDataIndext:0];
  
}
//- (NSArray<UIViewController *> *)SegmentPageViewChildViewControllers{
//    UIViewController *vc1 = [[TestViewController alloc]init];
//    UIViewController *vc2 = [[UIViewController alloc]init];
//    return @[vc2,vc1];
//}



- (UIView *)SegmentPageViewContentViewForItemAtIndexPath:(NSIndexPath *)indexPath{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor yellowColor];
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight =0;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = indexPath.item;
    tableView.tableFooterView = [[UIView alloc]init];
    return tableView;
}


- (void)getRequestDataIndext:(NSInteger)indext{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"延迟3s后执行");

        if (indext==0) {
            
            for (int i=0; i<10; i++) {
                MyItem *item = [[MyItem alloc]init];
                item.name = [NSString stringWithFormat:@"%@-测试-%d",@"a",i];
                [self.array1 addObject:item];
            }
            
            [self.pageView reloadData];
            
        }else if(indext==1){
            
            
            for (int i=0; i<30; i++) {
                MyItem *item = [[MyItem alloc]init];
                item.name = [NSString stringWithFormat:@"%@-测试-%d",@"b",i];
                [self.array2 addObject:item];
            }
            [self.pageView reloadData];
        }else{
            
            for (int i=0; i<30; i++) {
                MyItem *item = [[MyItem alloc]init];
                item.name = [NSString stringWithFormat:@"%@-测试-%d",@"b",i];
                [self.array3 addObject:item];
            }
            [self.pageView reloadData];
        }
    });
 
}

- (void)titleViewSeleced:(NSInteger)indext{
    
    [self getRequestDataIndext:indext];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return 45;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger moduleIndext = tableView.tag;
    
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
    
    if (moduleIndext==0) {
        MyItem *item = self.array1[indexPath.row];
        cell.textLabel.text = item.name;
    }
    if (moduleIndext==1) {
        MyItem *item = self.array2[indexPath.row];
        cell.textLabel.text = item.name;
    }
    if (moduleIndext==2) {
        MyItem *item = self.array3[indexPath.row];
        cell.textLabel.text = item.name;
    }
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    NSInteger moduleIndext = tableView.tag;
    
    if (moduleIndext==0) {
        return self.array1.count;
    }
    if (moduleIndext==1) {
        return self.array2.count;
    }

    return self.array3.count;
}


@end
