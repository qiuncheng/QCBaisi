//
//  QCEssenceViewController.m
//  QCTabbarController
//
//  Created by 程庆春 on 16/3/9.
//  Copyright © 2016年 QC Inc. All rights reserved.
//

#import "QCEssenceViewController.h"


@interface QCEssenceViewController ()

@end

@implementation QCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加左按钮

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(mainTagClick)];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.view.backgroundColor  =QCRGBColor(40, 50, 60);
    
}

- (void) mainTagClick {
    NSLog(@"点击了leftItem");
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end