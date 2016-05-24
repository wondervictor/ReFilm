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
{
    CGFloat summaryHeight;
}
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
@property (nonatomic, strong) UITextView *summaryField;
@property (nonatomic, strong) UIButton *inductionIndicator;
@property (nonatomic, assign) BOOL isExpanded;

/// 简短介绍(导演，上映时间，地区，类型)

@property (nonatomic, strong) UIView *breifInductionView;
/// 电影名
@property (nonatomic, strong) UILabel *movieTitleLabel;
/// 上映日期
@property (nonatomic, strong) UILabel *dateLabel;
/// 剧情
@property (nonatomic, strong) UILabel *plotTypeLabel;
/// 地区
@property (nonatomic, strong) UILabel *countryLabel;
/// 语言
@property (nonatomic, strong) UILabel *languageLabel;
/// 评分
@property (nonatomic, strong) UILabel *ratingLabel;
/// 在豆瓣中查看
@property (nonatomic, strong) UIButton *checkInButton;
///
@property (nonatomic, strong) UILabel *durationLabel;



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
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.pagingEnabled = NO;
    _mainScrollView.bounces = YES;
    
    _mainScrollView.contentSize = CGSizeMake(MAIN_WIDTH, 700);
    [self getImage];
    [self configureSubViews];
    [self configureMovieImageView];
    [self configureBriefInductionView];
    [self configureInductionView];
    [self getDetails];

    
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

#pragma mark - 简介View

- (void)configureBriefInductionView {
    
    _breifInductionView = [UIView new];
    _breifInductionView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:_breifInductionView];
    [_breifInductionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@120);
        make.top.equalTo(self.backImageView.mas_bottom).with.offset(3);
    }];
    
    // title
    _movieTitleLabel = [UILabel new];
    [_breifInductionView addSubview:_movieTitleLabel];
    [_movieTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_breifInductionView.mas_top);
        make.left.equalTo(_breifInductionView.mas_left);
        make.right.equalTo(_breifInductionView.mas_right);
        make.height.equalTo(@30);
    }];
    
    _movieTitleLabel.font = [UIFont systemFontOfSize:18];
    _movieTitleLabel.textAlignment = NSTextAlignmentCenter;
    _movieTitleLabel.textColor = [UIColor blackColor];
    
    
    // date
    _dateLabel = [UILabel new];
    [_breifInductionView addSubview:_dateLabel];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_movieTitleLabel.mas_bottom).with.offset(2);
        make.height.equalTo(@20);
        make.left.equalTo(_breifInductionView.mas_left);
        make.right.equalTo(_breifInductionView.mas_right);
    }];
    
    _dateLabel.font = [UIFont systemFontOfSize:13];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel.textColor = [UIColor lightGrayColor];
    
    
    
    // type
    _plotTypeLabel = [UILabel new];
    [_breifInductionView addSubview:_plotTypeLabel];
    [_plotTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dateLabel.mas_bottom).with.offset(2);
        make.height.equalTo(@20);
        make.left.equalTo(_breifInductionView.mas_left);
        make.right.equalTo(_breifInductionView.mas_right);
    }];
    _plotTypeLabel.textColor = [UIColor lightGrayColor];
    _plotTypeLabel.font = [UIFont systemFontOfSize:13];
    _plotTypeLabel.textAlignment = NSTextAlignmentCenter;
    
    
    _languageLabel = [UILabel new];
    [_breifInductionView addSubview:_languageLabel];
    [_languageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_plotTypeLabel.mas_bottom).with.offset(2);
        make.height.equalTo(@20);
        make.left.equalTo(_breifInductionView.mas_left);
        make.right.equalTo(_breifInductionView.mas_right);
    }];
    _languageLabel.textColor = [UIColor lightGrayColor];
    _languageLabel.font = [UIFont systemFontOfSize:13];
    _languageLabel.textAlignment = NSTextAlignmentCenter;
    
    
    _durationLabel = [UILabel new];
    [_breifInductionView addSubview:_durationLabel];
    [_durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_languageLabel.mas_bottom).with.offset(2);
        make.height.equalTo(@20);
        make.left.equalTo(_breifInductionView.mas_left);
        make.right.equalTo(_breifInductionView.mas_right);
    }];
    _durationLabel.textColor = [UIColor lightGrayColor];
    _durationLabel.font = [UIFont systemFontOfSize:13];
    _durationLabel.textAlignment = NSTextAlignmentCenter;
    
    
}


#pragma mark - 摘要
// InductionView
- (void)configureInductionView {
    _movieInduction = [UIView new];
    [self.mainScrollView addSubview:_movieInduction];
    _movieInduction.backgroundColor = [UIColor whiteColor];
    [_movieInduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_breifInductionView.mas_bottom).with.offset(3);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
       // estimate height
        make.height.equalTo(@100);
    }];
    
    UILabel *titleLabel = [UILabel new];
    [_movieInduction addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.top.equalTo(_movieInduction.mas_top);
        make.left.equalTo(_movieInduction.mas_left);
        make.width.equalTo(@100);
    }];
    titleLabel.text = @"剧情简介:";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15];
    
    summaryHeight = 60;
    
    _inductionIndicator = [[UIButton alloc]init];
    [_movieInduction addSubview:_inductionIndicator];
    [_inductionIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.equalTo(_movieInduction.mas_left).with.offset(50);
        make.right.equalTo(_movieInduction.mas_right).with.offset(-50);
        make.bottom.equalTo(_movieInduction.mas_bottom);
    }];
    _isExpanded = NO;
    [_inductionIndicator setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    _inductionIndicator.titleLabel.font = [UIFont systemFontOfSize:12];
    [_inductionIndicator setTitle:@"展开" forState:UIControlStateNormal];
    [_inductionIndicator addTarget:self action:@selector(expandInduction:) forControlEvents:UIControlEventTouchUpInside];
    
    _summaryField = [[UITextView alloc]init];
    [_movieInduction addSubview:_summaryField];
    [_summaryField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.bottom.equalTo(_inductionIndicator.mas_top);
        make.left.equalTo(_movieInduction.mas_left).with.offset(10);
        make.right.equalTo(_movieInduction.mas_right).with.offset(-10);
    }];
    

    _summaryField.userInteractionEnabled = NO;
   // _summaryField.numberOfLines = 0;
    //[_summaryField textRectForBounds:CGRectInset(_summaryField.bounds, 2, 10) limitedToNumberOfLines:0];
   // _summaryField.lineBreakMode = NSLineBreakByWordWrapping;
    _summaryField.font = [UIFont systemFontOfSize:12];
    
}

- (void)expandInduction:(UIButton *)sender {
    
    if (_isExpanded == NO) {
        NSString *text = _summaryField.text;
        NSMutableParagraphStyle *paragrapgStyle = [[NSMutableParagraphStyle alloc]init];
        paragrapgStyle.lineSpacing = 5;
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:paragrapgStyle};
        _summaryField.attributedText = [[NSAttributedString alloc]initWithString:text attributes:attribute];
        CGRect rect = [text boundingRectWithSize:CGSizeMake(MAIN_WIDTH-20, 900) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
        summaryHeight = rect.size.height;
        [UIView animateWithDuration:0.3 animations:^{
            [_movieInduction mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo([NSNumber numberWithFloat:(summaryHeight + 60)]);
            }];
        }];
        [sender setTitle:@"收起" forState:UIControlStateNormal];
        _isExpanded = YES;
    }
    else {
        summaryHeight = 60;
        [UIView animateWithDuration:0.3 animations:^{
            [_movieInduction mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo([NSNumber numberWithFloat:(100)]);
            }];
        }];
        [sender setTitle:@"展开" forState:UIControlStateNormal];

        _isExpanded = NO;
    }
}


#pragma mark - 电影封图
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
                        NSLog(@"fsgdhfj");
                        _movie.movieImage = [UIImage imageWithData:imageData];
                        _backImageView.image = _movie.movieImage;
                        _movieImageView.image = _movie.movieImage;
                        [manager saveImageData:imaData imageID:_movie.movieID];
                    });
                }
            });
        }
    }
    else {
        _movieImageView.image = _movie.movieImage;
        _backImageView.image = _movie.movieImage;
    }
}


- (void)favoriteButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Favorite");
    RFDataManager *manager = [RFDataManager sharedManager];
    [manager addFavoriteMovie:self.movie];
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
    dispatch_async(dispatch_get_main_queue(), ^{
       // _summaryField.text = movies.summary;
        NSMutableParagraphStyle *paragrapgStyle = [[NSMutableParagraphStyle alloc]init];
        paragrapgStyle.lineSpacing = 5;
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:paragrapgStyle};
        _summaryField.attributedText = [[NSAttributedString alloc]initWithString:movies.summary attributes:attribute];
        
        _movieDetail = movies;
        
        _languageLabel.text = movies.movieLanguage;
        _movieTitleLabel.text = _movie.title;
        _dateLabel.text = [movies.pubdate firstObject];
        _durationLabel.text = movies.movieDuration;
        NSMutableString *type = [NSMutableString new];
        for (NSString *item in movies.genres) {
            [type appendFormat:@"%@ ",item];
        }
        _plotTypeLabel.text = type;
        
        
        
        
        
        
        //NSLog(@"%@",)
    });
}
@end
