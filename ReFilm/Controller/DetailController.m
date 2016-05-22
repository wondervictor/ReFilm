//
//  DetailController.m
//  ReFilm
//
//  Created by VicChan on 5/13/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "DetailController.h"
#import <Masonry.h>
#import "RFDataManager.h"
#import "MovieDetail.h"


#define MAIN_HEIGHT    (self.view.frame.size.height)
#define MAIN_WIDTH    (self.view.frame.size.width)


@interface DetailController()<UIScrollViewDelegate, RFDataManagerDelegate>
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
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *inductionIndicator;
/// 简短介绍(导演，上映时间，地区，类型)

@property (nonatomic, strong) UIView *breifInductionView;

@property (nonatomic, strong) MovieDetail *movieDetail;

/// UIScrollView 的size 和 contentOffSet
@property (nonatomic, assign) CGSize contentSize;

@property (nonatomic, assign) CGFloat offSetY;

@end


@implementation DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详细信息";
    self.view.backgroundColor = [UIColor whiteColor];
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, MAIN_WIDTH, MAIN_HEIGHT-49)];
    [self.view addSubview:_mainScrollView];
    _mainScrollView.showsVerticalScrollIndicator = YES;
    _mainScrollView.backgroundColor = [UIColor greenColor];
    _mainScrollView.pagingEnabled = NO;
    _mainScrollView.bounces = YES;
    
    _mainScrollView.contentSize = CGSizeMake(MAIN_WIDTH, 700);
    [self getImage];
    [self getDetails];
    [self configureSubViews];
    [self configureMovieImageView];
    [self configureBriefInductionView];
    
}

#if 1 //Test for Image
- (void)getImage {
//
    RFDataManager *manager = [RFDataManager sharedManager];
    NSData *imaData = [manager getImageWithID:@"26614128"];
    self.movieImage = [UIImage imageWithData:imaData];
}

#endif

- (void)configureSubViews {
    UIBarButtonItem *favoriteButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"favoriteButton"] style:UIBarButtonItemStylePlain target:self action:@selector(favoriteButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem = favoriteButton;
    

    
    
    
    
    
}

- (void)configureBriefInductionView {
    _breifInductionView = [UIView new];
    [self.view addSubview:_breifInductionView];
    [_breifInductionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@100);
        make.top.equalTo(self.backImageView.mas_bottom);
    }];
    
}



// InductionView
- (void)configureInductionView {
    _movieInduction = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    
    
    [self.mainScrollView addSubview:_movieInduction];
}

- (void)configureMovieImageView {
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, 150)];
    [_mainScrollView addSubview:_backImageView];

    _backImageView.contentMode = UIViewContentModeScaleToFill;
    
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
    /*
    _backImageView.image = self.movieImage;
    _movieImageView.image = self.movieImage;
    */
    if (!_movie.movieImage) {
        RFDataManager *manager = [RFDataManager sharedManager];
        NSData *imaData = [manager getImageWithID:_movie.movieID];
        if (imaData) {
            _movie.movieImage = [UIImage imageWithData:imaData];
            _movie.movieImage = [UIImage imageWithData:imaData];
            _backImageView.image = _movie.movieImage;
            _movieImageView.image = _movie.movieImage;
        }
        else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:_movie.imageURL]];
                if (imageData) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _movie.movieImage = [UIImage imageWithData:imageData];
                        _backImageView.image = _movie.movieImage;
                        _movieImageView.image = _movie.movieImage;
                        [manager saveImageData:imaData imageID:_movie.movieID];
                    });
                }
            });
        }
    }
}


- (void)favoriteButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Favorite");
}

#pragma mark - Reuqest

- (void)getDetails {
    RFDataManager *manager = [RFDataManager sharedManager];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [manager sendRequestForMovieWithID:_movie.movieID];
        manager.delegate = self;
    });
}
#pragma mark - RFDataManagerDelegate

- (void)didReceiveMovieInfo:(MovieDetail *)movies error:(NSString *)error {
    NSLog(@"%@",movies);
}
@end
