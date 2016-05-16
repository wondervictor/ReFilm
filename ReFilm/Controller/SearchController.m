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

static BOOL cancel = NO;


@implementation SearchController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 260, 30)];
    _searchBar.barTintColor = [UIColor clearColor];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"输入您感兴趣的电影";
    self.navigationItem.titleView = _searchBar;

    
}


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




@end
