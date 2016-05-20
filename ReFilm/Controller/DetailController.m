//
//  DetailController.m
//  ReFilm
//
//  Created by VicChan on 5/13/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "DetailController.h"
#import <Masonry.h>

#define MAIN_HEIGHT    (self.view.frame.size.height)
#define MAIN_WIDTH    (self.view.frame.size.width)

@interface DetailController()<UIScrollViewDelegate>
/// 主要的ScrollView
@property (nonatomic, strong) UIScrollView *mainScrollView;
/// 电影海报
@property (nonatomic, strong) UIImageView *movieImageView;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImage *movieImage;
/// 演员列表
@property (nonatomic, strong) UITableView *actorTableView;
/// 电影介绍
@property (nonatomic, strong) UIView *movieInduction;
/// 简短介绍(导演，上映时间，地区，类型)
@property (nonatomic, strong) UIView *breifInductionView;



@end


@implementation DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详细信息";
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor whiteColor];
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MAIN_WIDTH, MAIN_HEIGHT-113)];
    [self.view addSubview:_mainScrollView];
    _mainScrollView.showsVerticalScrollIndicator = YES;
    _mainScrollView.backgroundColor = [UIColor greenColor];
    
    
    [self configureSubViews];
}

- (void)configureSubViews {
    UIBarButtonItem *favoriteButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"favoriteButton"] style:UIBarButtonItemStylePlain target:self action:@selector(favoriteButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem = favoriteButton;
    

    
    
    
    
    
}


// InductionView
- (void)configureInductionView {
    _movieInduction = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    
    
    [self.mainScrollView addSubview:_movieInduction];
}

- (void)configureMovieImageView {
    self.backImageView = [UIImageView new];
    [_mainScrollView addSubview:_backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mainScrollView.mas_top);
        make.left.equalTo(_mainScrollView.mas_left);
        make.right.equalTo(_mainScrollView.mas_right);
        make.height.equalTo(@150);
    }];
    
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    visualView.frame = CGRectMake(0, 0, MAIN_WIDTH, 150);
    
    [_backImageView addSubview:visualView];
    
    _movieImageView = [[UIImageView alloc]init];
    [visualView addSubview:_movieImageView];
    [_movieImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(visualView.mas_height);
        make.width.equalTo(visualView.mas_height).multipliedBy(42/60.0);
        make.centerY.equalTo(visualView.mas_centerY);
        make.centerX.equalTo(visualView.mas_centerX);
    }];
    
    

}


- (void)favoriteButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Favorite");
}


@end
