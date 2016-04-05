//
//  QCTopicViewController.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/4/5.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCTopicViewController.h"
#import "QCTopicCell.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "QCTopic.h"

@interface QCTopicViewController ()

@property (strong, nonatomic) NSMutableArray *topics;
@end

@implementation QCTopicViewController
/**
 *  cell ID
 */
static NSString * const topicCellId = @"topicCell";
/**
 *  懒加载获取数据
 */
- (NSMutableArray *)topics {
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [self.tableView.mj_header beginRefreshing];
    /**
     *  设置自动改变header的透明度
     */
    [self.tableView.mj_header setAutomaticallyChangeAlpha:YES];
    
    /**
     *  注册nib
     */
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCTopicCell class]) bundle:nil] forCellReuseIdentifier:topicCellId];
    
    self.tableView.rowHeight = 154.0;
}

- (void )refreshData {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        NSLog(@"%@", responseObject[@"list"]);
        
        self.topics = [QCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        //        NSLog(@"the count of topics is %zd", self.topics.count);
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}
/**
 *  加载新的数据
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCellId forIndexPath:indexPath];
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}
@end