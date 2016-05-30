//
//  SettingController.m
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "SettingController.h"
#import "RFDataManager.h"
#import "ReFilm-Swift.h"

#define MAIN_HEIGHT    (self.view.frame.size.height)
#define MAIN_WIDTH    (self.view.frame.size.width)



@interface SettingController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *settingTableView;

@property (nonatomic, strong) NSArray *settings;

@property (nonatomic, strong) RFProgressHUD *progressHUD;

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    self.settings = @[@"清除缓存记录"];
    self.settingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT - 64) style:UITableViewStyleGrouped];
    self.progressHUD = [[RFProgressHUD alloc]initWithFrame:CGRectMake(MAIN_WIDTH/2.0 - 60, MAIN_HEIGHT/2.0 - 100,120 , 120) radius:30 duration:3 parentView:self.view];;
    self.settingTableView.backgroundColor = [UIColor whiteColor];
    self.settingTableView.delegate = self;
    self.settingTableView.dataSource = self;
    [self.view addSubview:self.settingTableView];

}


#pragma mark - UITableViewDelegate UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = [self.settings objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.settings count];
    }
    else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"您确定要清空缓存吗？" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self removeStoreCache];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:confirm];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)removeStoreCache {
    RFDataManager *manager = [RFDataManager sharedManager];
    [manager removeAllImageData];
    [self.progressHUD stopWithSuccess:@"清除成功"];
}


@end
