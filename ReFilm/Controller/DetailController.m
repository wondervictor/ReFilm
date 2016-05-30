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
#import "ReFilm-Swift.h"
#import "RFViewModel.h"
#import "WebController.h"
#import "MovieComment.h"



#define MAIN_HEIGHT    (self.view.frame.size.height)
#define MAIN_WIDTH    (self.view.frame.size.width)


@interface DetailController()<UIScrollViewDelegate, RFDataManagerDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger numberOfActors;
    CGFloat summaryHeight;
}

@property (nonatomic, strong) RFProgressHUD *progressHUD;

/// 主要的ScrollView
@property (nonatomic, strong) UIScrollView *mainScrollView;
/// 电影海报
@property (nonatomic, strong) UIImageView *movieImageView;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImage *movieImage;
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

/// 演员
@property (nonatomic, strong) UIView *actorView;
@property (nonatomic, strong) UICollectionView *movieActorView;
@property (nonatomic, strong) NSArray *movieActors;


/// Review
@property (nonatomic, strong) UIView *movieReview;
@property (nonatomic, strong) UITableView *commentTable;
@property (nonatomic, strong) NSArray *comments;


/// FooterView
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UIButton *openWebButton;
@property (nonatomic, strong) UILabel *footerLabel;

@end

static NSString *const collectionCellIdentifier = @"ActorCell";
static NSString *const commentCellIdentifier = @"CommentCell";


@implementation DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详细信息";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.progressHUD = [[RFProgressHUD alloc]initWithFrame:CGRectMake(MAIN_WIDTH/2.0 - 60, MAIN_HEIGHT/2.0 - 100,120 , 120) radius:30 duration:3 parentView:self.view];
    [self.progressHUD startAnimating];
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,64, MAIN_WIDTH, MAIN_HEIGHT-64)];
    [self.view addSubview:_mainScrollView];
    
    _mainScrollView.showsVerticalScrollIndicator = YES;
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.pagingEnabled = NO;
    _mainScrollView.delegate = self;
    _mainScrollView.bounces = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _mainScrollView.contentSize = CGSizeMake(MAIN_WIDTH, 1500);
    numberOfActors = _movie.movieActors.count;
    self.movieActors = _movie.movieActors;
    [self getImage];
    [self configureSubViews];
    [self configureMovieImageView];
    [self configureBriefInductionView];
    [self configureInductionView];
    [self getDetails];
    self.comments = [NSArray new];
    [self setCommentArray];
    
    
    
    [self configureMovieActor];
    [self configureCommentView];
    
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

- (void)viewDidLayoutSubviews {
    _mainScrollView.contentSize = CGSizeMake(MAIN_WIDTH, 1500);

}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //NSLog(@"%@",NSStringFromCGPoint(self.backImageView.frame.origin))
    CGFloat offset = scrollView.contentOffset.y;
    NSLog(@"%f", offset);
    
    if (offset<=0) {
        CGRect rect = _backImageView.frame;
        rect.origin.y = offset;
        rect.size.height = 150 -offset;
        _backImageView.frame = rect;
    }
}



#pragma mark - Test for Comment

- (void)setCommentArray {
    MovieComment *comment1 = [MovieComment new];
    comment1.name = @"大象";
    comment1.comment = @"第一次看的时候，觉得这就是三个无关联的故事。 第一个故事里，陈经理去广西出差，在陌生的城市跟踪从小就没见过了的父亲。 曾经炒掉过几百人的父亲，如今是个有不少白发的瘸子，做最低廉的工作。 而陈经理事业有成，出差在外，有人唯唯诺诺地跟着。 这样的一个冷静克制，风度翩翩（难以接近）的人，跟在落魄的父亲身后，就像在拍纪录片一样记录老人生活的细节—— 去找活............ ";
    
    MovieComment *comment2 = [MovieComment new];
    comment2.name = @"世界那么大";
    comment2.comment = @"5月10日的北京颐堤港，陈柏霖穿着非常得体的西服在影厅门口为首映礼做准备，不知被哪个粉丝看见了忽然大叫了一声他的名字。陈抬起头本能就是一个微笑，既然被发现了他就大大方方的抢了一个话筒，他说，好像主持人还没来哎，我就先代替一下吧。说着就领着大队伍浩浩荡荡的进了场。 怎么回事啊？他在大场合下是如此的自如又得体。 我们回到电影，在那样能发觉每一个细微表情的............";
    MovieComment *comment3 = [MovieComment new];
    comment3.name = @" yueer";
    comment3.comment = @"刚看完由陈哲艺监製，并跨国连三位新生代忻钰坤、陈世杰、Sivaroj Kongsakul导演，陈柏霖、秦沛、蒋雯丽、杨祐宁、小茶领衔主演的《再见，在也不见》，感受是闷、很闷、极度闷。 主角失落的人生让我极度失望。 三个故事，三种情感，三段人生。温吞到沉闷的矫情作品，无法相认的父子俩，万千阻隔的断背情，暗涌深藏的师生恋，每段都矫情， 陈柏霖的表演在我看得好累，亲情、同............";
    MovieComment *comment4 = [MovieComment new];
    comment4.name = @"梦沉雨夜";
    comment4.comment = @"金马影展的开幕影片，一部真正意义上的分段式电影，讲述亲情、友情、爱情三段不同的故事，由三个不同的导演打造，却由同一个人演绎，保持统一的情感基调，别有一番韵味。 《再见，在也不见》，一个很有意思的片名，既然再见，那难道不是再也不见，为何又在，也不见呢，主题曲《在，也不见》更是让人产生无限遐想，而影片的英文名《Distance》则像是在说，即使相见也有那永远无...........";
    MovieComment *comment5 = [MovieComment new];
    comment5.name = @"水漾薄荷";
    comment5.comment = @"被电影名吸引而进入影院，开始看到这个片名的时候略感意外，为什么是“再见，在也不见”，而不是“再见，再也不见”呢？看了片子后明白，有些事，有些人，错过了，即使还在，见还不如不见，这点我非常认同。有些过去的往事，随风而逝，随时间的流逝，各自已不再是当时的那个自己，即便再见，也不再是当年的模样和心境，何不如留住曾经的美好！存在记忆的心底，作为一种怀念，......";
    
    NSMutableArray *list = [NSMutableArray new];
    [list addObject:comment1];
    [list addObject:comment2];
    [list addObject:comment3];
    [list addObject:comment4];
    [list addObject:comment5];
    self.comments = list;
    [self.commentTable reloadData];

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
    
    _movieTitleLabel.font = [UIFont systemFontOfSize:20];
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
    
    _dateLabel.font = [UIFont systemFontOfSize:15];
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
    _plotTypeLabel.font = [UIFont systemFontOfSize:15];
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
    _languageLabel.font = [UIFont systemFontOfSize:15];
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
    _durationLabel.font = [UIFont systemFontOfSize:15];
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
        make.height.equalTo(@120);
    }];
    
    UILabel *titleLabel = [UILabel new];
    [_movieInduction addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.top.equalTo(_movieInduction.mas_top);
        make.left.equalTo(_movieInduction.mas_left).with.offset(15);
        make.right.equalTo(_movieInduction.mas_right).with.offset(-15);
    }];
    titleLabel.text = @"剧情简介:";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor greenColor];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.strokeColor = [UIColor greenColor].CGColor;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 20);
    CGPathAddLineToPoint(path, NULL, MAIN_WIDTH-30, 20);
    lineLayer.path = path;
    CGPathRelease(path);
    [titleLabel.layer addSublayer:lineLayer];
    
    
    
    summaryHeight = 70;
    
    _inductionIndicator = [[UIButton alloc]init];
    [_movieInduction addSubview:_inductionIndicator];
    [_inductionIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.equalTo(_movieInduction.mas_left).with.offset(50);
        make.right.equalTo(_movieInduction.mas_right).with.offset(-50);
        make.bottom.equalTo(_movieInduction.mas_bottom);
    }];
    _isExpanded = NO;
    [_inductionIndicator setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    _inductionIndicator.titleLabel.font = [UIFont systemFontOfSize:16];
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

    
}

- (void)expandInduction:(UIButton *)sender {
    
    if (_isExpanded == NO) {
        NSString *text = _summaryField.text;
        NSMutableParagraphStyle *paragrapgStyle = [[NSMutableParagraphStyle alloc]init];
        paragrapgStyle.lineSpacing = 5;
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragrapgStyle};
        _summaryField.attributedText = [[NSAttributedString alloc]initWithString:text attributes:attribute];
        CGRect rect = [text boundingRectWithSize:CGSizeMake(MAIN_WIDTH-20, 900) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
        summaryHeight = rect.size.height;
        [UIView animateWithDuration:0.3 animations:^{
            [_movieInduction mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo([NSNumber numberWithFloat:(summaryHeight + 80)]);
            }];
        }];
        [sender setTitle:@"收起" forState:UIControlStateNormal];
        _isExpanded = YES;
    }
    else {
        summaryHeight = 70;
        [UIView animateWithDuration:0.3 animations:^{
            [_movieInduction mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo([NSNumber numberWithFloat:(120)]);
            }];
        }];
        [sender setTitle:@"展开" forState:UIControlStateNormal];

        _isExpanded = NO;
    }
}


#pragma mark - 演员视图

- (void)configureMovieActor {
    
    _actorView = [UIView new];
    [self.mainScrollView addSubview:_actorView];
    [_actorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.movieInduction.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@174);
    }];
    _actorView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [UILabel new];
    [self.actorView addSubview:titleLabel];
    titleLabel.text = @"演员";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor greenColor];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.top.equalTo(_actorView.mas_top);
        make.left.equalTo(_actorView.mas_left).with.offset(15);
        make.right.equalTo(_actorView.mas_right).with.offset(-15);
    }];
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.strokeColor = [UIColor greenColor].CGColor;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 20);
    CGPathAddLineToPoint(path, NULL, MAIN_WIDTH-30, 20);
    lineLayer.path = path;
    CGPathRelease(path);
    [titleLabel.layer addSublayer:lineLayer];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    //flowLayout.minimumInteritemSpacing = 5;
    self.movieActorView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    [self.actorView addSubview:self.movieActorView];
    //self.movieActorView.
    [self.movieActorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).with.offset(4);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo([NSNumber numberWithFloat:150]);
    }];
    self.movieActorView.backgroundColor = [UIColor whiteColor];
    self.movieActorView.delegate = self;
    self.movieActorView.dataSource = self;
    [self.movieActorView registerClass:[ActorCollectionCell class] forCellWithReuseIdentifier:@"ActorCell"];

}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ActorCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIdentifier forIndexPath:indexPath ];
    
    RFViewModel *rfViewModel = [[RFViewModel alloc]init];
    [rfViewModel handleMovieActorCell:cell withMovie:[self.movieActors objectAtIndex:indexPath.item]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"count:%lu",self.movieActors.count);
    return self.movieActors.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 150);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.item;
    MovieActor *actor = [_movieActors objectAtIndex:index];
    self.hidesBottomBarWhenPushed = YES;
    WebController *web = [[WebController alloc]init];
    web.openURL = actor.actorInfo;
    web.movie = self.movie;
    [self showViewController:web sender:nil];
}


#pragma mark - 电影封图
- (void)configureMovieImageView {
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, 150)];
    [_mainScrollView addSubview:_backImageView];

    _backImageView.contentMode = UIViewContentModeScaleToFill;
    
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    //visualView.frame = _backImageView.bounds;//CGRectMake(0, 0, MAIN_WIDTH, 150);
    [_backImageView addSubview:visualView];
    [visualView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backImageView.mas_top);
        make.left.equalTo(_backImageView.mas_left);
        make.right.equalTo(_backImageView.mas_right);
        make.bottom.equalTo(_backImageView.mas_bottom);
    }];
    
    
    
    
    
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


- (void)configureCommentView {
   
    
    self.movieReview = [[UIView alloc]init]; //WithFrame:CGRectMake(0, 700, MAIN_WIDTH, 320)];
    [self.mainScrollView addSubview:self.movieReview];
    self.mainScrollView.scrollEnabled = YES;

    self.movieReview.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *topConstriant = [NSLayoutConstraint constraintWithItem:self.movieReview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.movieInduction attribute:NSLayoutAttributeBottom multiplier:1 constant:190];
    topConstriant.active = YES;
    
    NSLayoutConstraint *leftConstriant = [NSLayoutConstraint constraintWithItem:self.movieReview attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    leftConstriant.active = YES;
    
    NSLayoutConstraint *rightConstriant = [NSLayoutConstraint constraintWithItem:self.movieReview attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    rightConstriant.active = YES;
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.movieReview attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:370];
    heightConstraint.active = YES;
                        
    /*
    [self.movieReview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.movieActorView.mas_bottom).with.offset(10);
        make.left.equalTo(self.mainScrollView.mas_left);
        make.right.equalTo(self.mainScrollView.mas_right);
        make.height.equalTo(@330);
    }];
    
    */
    self.movieReview.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [UILabel new];
    self.mainScrollView.scrollEnabled = YES;
    [self.movieReview addSubview:titleLabel];
    titleLabel.text = @"电影评论";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor greenColor];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.top.equalTo(_movieReview.mas_top);
        make.left.equalTo(_movieReview.mas_left).with.offset(15);
        make.right.equalTo(_movieReview.mas_right).with.offset(-15);
    }];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.strokeColor = [UIColor greenColor].CGColor;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 20);
    CGPathAddLineToPoint(path, NULL, MAIN_WIDTH-30, 20);
    lineLayer.path = path;
    CGPathRelease(path);
    [titleLabel.layer addSublayer:lineLayer];

    self.commentTable = [UITableView new];
    [self.movieReview addSubview:self.commentTable];
    
    [self.commentTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).with.offset(4);
        make.left.equalTo(self.movieReview.mas_left);
        make.right.equalTo(self.movieReview.mas_right);
        make.height.equalTo(@350);
    }];
    
    CAShapeLayer *lineLayers = [CAShapeLayer layer];
    lineLayers.strokeColor = [UIColor greenColor].CGColor;
    lineLayers.lineWidth = 1;
    CGMutablePathRef paths = CGPathCreateMutable();
    CGPathMoveToPoint(paths, NULL, 15, 375);
    CGPathAddLineToPoint(paths, NULL, MAIN_WIDTH-25, 375);
    lineLayers.path = paths;
    CGPathRelease(paths);
    [self.movieReview.layer addSublayer:lineLayers];
    
    self.commentTable.delegate = self;
    self.commentTable.dataSource = self;
    self.commentTable.estimatedRowHeight = 60;
    self.commentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.commentTable registerClass:[CommentCell class] forCellReuseIdentifier:commentCellIdentifier];
    self.mainScrollView.scrollEnabled = YES;

}

#pragma mark - UITableViewDelegate || UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellIdentifier forIndexPath:indexPath];
    RFViewModel *viewModel = [[RFViewModel alloc]init];
    [viewModel handleCommentCell:cell withComment:[self.comments objectAtIndex:indexPath.row]];
    return cell;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieComment *commnet = [self.comments objectAtIndex:indexPath.row];
    NSString *text = commnet.comment;
    NSMutableParagraphStyle *paragrapgStyle = [[NSMutableParagraphStyle alloc]init];
    paragrapgStyle.lineSpacing = 5;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:paragrapgStyle};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAIN_WIDTH-20, 999) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    CGFloat commentHeight = rect.size.height;
    return commentHeight+20;
}



- (void)favoriteButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Favorite");
    RFDataManager *manager = [RFDataManager sharedManager];
    [manager addFavoriteMovie:self.movie];
}

- (void)configureFooterView {
    
}
/*
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"asDFGFDHJKHJHGFDS");
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scroll");
}

*/

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
        NSMutableParagraphStyle *paragrapgStyle = [[NSMutableParagraphStyle alloc]init];
        paragrapgStyle.lineSpacing = 5;
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragrapgStyle};
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
        
        [self.progressHUD stopWithSuccess:@"加载完成"];
        
    });
}
@end
