//
//  SearchController.m
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "SearchController.h"
#import "RFDataManager.h"

@interface SearchController()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@end


@implementation SearchController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 260, 30)];
    _searchBar.barTintColor = [UIColor clearColor];
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    _searchBar.placeholder = @"输入您感兴趣的电影";
    self.navigationItem.titleView = _searchBar;

    
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"click");
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {

}

@end
