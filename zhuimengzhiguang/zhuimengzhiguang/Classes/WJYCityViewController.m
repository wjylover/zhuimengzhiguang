//
//  WJYCityViewController.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/13.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "WJYCityViewController.h"
#import "WJYDataManager.h"
#import "City.h"
@interface WJYCityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *cityTableView;
@property (nonatomic, strong) NSMutableArray *cityAllArray;
@property (nonatomic, strong) NSMutableArray *allHeadArray;
@end

@implementation WJYCityViewController

- (IBAction)backButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

- (void)viewWillAppear:(BOOL)animated
{
    self.cityAllArray = [NSMutableArray arrayWithCapacity:30];
    self.allHeadArray = [NSMutableArray arrayWithCapacity:30];
    self.cityAllArray = [WJYDataManager sharedManager].cityAllArray;
    for (NSDictionary *dict in _cityAllArray) {
        NSString *head = nil;
        if ([dict[@"header"] isEqualToString:@"热门城市"]) {
            head = [dict[@"header"] substringToIndex:2];
        }else{
            head = dict[@"header"];
        }
        
        [self.allHeadArray addObject:head];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityAllArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cityAllArray[section][@"cells"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *cityArray = self.cityAllArray[indexPath.section][@"cells"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    City *city = cityArray[indexPath.row];
    cell.textLabel.text = [city valueForKey:@"city_name"];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *cityArray = self.cityAllArray[indexPath.section][@"cells"];
    City *city = cityArray[indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
    self.reloadBlock([[city valueForKey:@"city_id"] integerValue],[city valueForKey:@"city_name"]);
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _allHeadArray[section];
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.allHeadArray;
}



@end
