//
//  SearchController.m
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "SearchController.h"
#import "RFDataManager.h"
#import <Masonry.h>
#import "MovieTableCell.h"
#import "RFViewModel.h"
#import "DetailController.h"
#import "ReFilm-Swift.h"


#define MAIN_HEIGHT    (self.view.frame.size.height)
#define MAIN_WIDTH    (self.view.frame.size.width)

@interface SearchController()<RFDataManagerDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) RFProgressHUD *progressHUD;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UITableView *resultTableView;

@property (nonatomic, strong) NSArray *resultLists;


@end

static BOOL cancel = NO;
static NSString *const cellIdentifier = @"cell";

@implementation SearchController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 260, 30)];
    _searchBar.barTintColor = [UIColor clearColor];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"输入您感兴趣的电影";
    self.navigationItem.titleView = _searchBar;
    self.progressHUD = [[RFProgressHUD alloc]initWithFrame:CGRectMake(MAIN_WIDTH/2.0 - 60, MAIN_HEIGHT/2.0 - 100,120 , 120) radius:30 duration:3 parentView:self.view];

    _resultTableView = [[UITableView alloc]init];
    [self.view addSubview:_resultTableView];
    [_resultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    _resultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _resultTableView.dataSource = self;
    _resultTableView.delegate = self;
    [_resultTableView registerClass:[MovieTableCell class] forCellReuseIdentifier:cellIdentifier];
    
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    cancel = YES;
    [searchBar resignFirstResponder];
    searchBar.text = @"";
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    NSString *search = searchBar.text;
    if ([search isEqualToString:@""]) {
        return;
    }
    else {
        [self seachMovie:search];
        [self.progressHUD startAnimatingWithTitile:@"正在搜索"];
        //[self searchBarCancelButtonClicked:searchBar];
    }
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    // 取消按钮
    for(id cc in [searchBar.subviews[0] subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}



- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    if (cancel == YES) {
        [searchBar setShowsCancelButton:NO animated:YES
         ];
        cancel = NO;
    } else {
        NSLog(@"search: %@",searchBar.text);
    }

}

- (void)seachMovie:(NSString *)movieName {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        RFDataManager *manager = [RFDataManager sharedManager];
        manager.delegate = self;
        [manager sendRequestSearchMovieWithName:movieName];
    });
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    RFViewModel *rfViewModel = [[RFViewModel alloc]init];
    [rfViewModel handleTableCell:cell withMovie:[self.resultLists objectAtIndex:indexPath.row]];
    return  cell;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.resultLists count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailController *detailController = [DetailController new];
    detailController.movie = [self.resultLists objectAtIndex:indexPath.row];
    [self showViewController:detailController sender:nil];
}




#pragma mark - RFDataManagerDelegate
- (void)didReceiveSearchMovies:(NSArray *)movies error:(NSString *)error {
    if (error) {
        NSLog(@"error : %@",error);
        [self.progressHUD stopWithError:@"搜索故障"];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.resultLists = movies;
            [self.resultTableView reloadData];
            [self.progressHUD stopWithSuccess:@"搜索成功"];
        });
    }
}






@end
