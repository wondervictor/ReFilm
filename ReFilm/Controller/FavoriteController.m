//
//  FavoriteController.m
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "FavoriteController.h"
#import "MovieTableCell.h"


#define MAIN_HEIGHT   (self.view.frame.size.height)
#define MAIN_WIDTH    (self.view.frame.size.width)


@interface FavoriteController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *movies;

@end



@implementation FavoriteController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT-113) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    
    
}


#pragma mark - UITableViewDataSource || UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;//[self.movies count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    if (cell == nil) {
        cell = [[MovieTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MovieCell"];
    }
    
    return cell;
}





@end
