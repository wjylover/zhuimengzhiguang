//
//  HotContentViewController.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/11.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "HotContentViewController.h"
#import "HotContentCell.h"

@interface HotContentViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *hotContentTableView;

@end

@implementation HotContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 自适应高度
    _hotContentTableView.rowHeight = UITableViewAutomaticDimension;
    _hotContentTableView.estimatedRowHeight = 100;
    [_hotContentTableView registerNib:[UINib nibWithNibName:@"HotContentCell" bundle:nil] forCellReuseIdentifier:@"HotContent"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotContent" forIndexPath:indexPath];
    return cell;
}
@end
