//
//  TopView.m
//  ReFilm
//
//  Created by VicChan on 5/22/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "TopView.h"
#import "TopMovieCell.h"
#import "RFViewModel.h"

#define MAIN_WIDTH   (self.frame.size.width)
#define MAIN_HEIGHT  (self.frame.size.height)

@interface TopView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *const reuseIdentifier = @"as";

@implementation TopView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark - UITableViewDelegate || UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];//[tableView dequeueReusableCellWithIdentifier:@"topCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[TopMovieCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    RFViewModel *rfViewModel = [[RFViewModel alloc]init];
    [rfViewModel handleTopTableCell:cell withMovie:[self.topMovies objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.topMovies count];
}

- (void)loadWithArray:(NSArray *)movies {
    self.topMovies = movies;
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
