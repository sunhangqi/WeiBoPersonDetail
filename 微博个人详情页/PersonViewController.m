//
//  PersonViewController.m
//  微博个人详情页
//
//  Created by Macbook on 2017/5/13.
//  Copyright © 2017年 Macbook. All rights reserved.
//

#import "PersonViewController.h"
#import "UIImage+Image.h"

#define oriOffY -244
#define oriHeight 200

@interface PersonViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstr;

@end

@implementation PersonViewController
static NSString *ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init]forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //设置tableView偏移量
    self.tableView.contentInset = UIEdgeInsetsMake(180, 0, 0, 0);
    
    //设置标题
    UILabel *title = [[UILabel alloc] init];
    title.text = @"个人详情页";
    [title sizeToFit];
    self.navigationItem.titleView = title;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //求偏移量：当前点-原始点
    NSLog(@"%f",scrollView.contentOffset.y);
    CGFloat offset = scrollView.contentOffset.y - oriOffY;
    NSLog(@"%f",offset);
    CGFloat h = oriHeight - offset;
    if (h < 64){
        h = 64;
    }
    self.heightConstr.constant = h;
    
    //修改导航条背景图片
    //根据透明度来生成图片
    CGFloat alpha = offset / 136.0;
    
    //当alpha>1时又变成透明，因此设置成0.99
    if (alpha >= 1.0) {
        alpha = 0.99;
    }
    
    //把颜色创建成图片
    UIColor *alphaColor = [UIColor colorWithWhite:1.0 alpha:alpha];
    UIImage *alphaImage = [UIImage imageWithColor:alphaColor];
    
    //修改导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:alphaImage forBarMetrics:UIBarMetricsDefault];
    
    //设置标题
    UILabel *title = (UILabel *)self.navigationItem.titleView;
    title.textColor = [UIColor colorWithWhite:0.0 alpha:alpha];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.textLabel.text = @"shq";
    return cell;
}

@end
