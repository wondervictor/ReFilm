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


@interface SearchController()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

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

    _resultTableView = [[UITableView alloc]init];
    [self.view addSubview:_resultTableView];
    [_resultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
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


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    return  cell;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
