//
//  MasterViewController.m
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//
// Controller
#import "MasterViewController.h"
#import "SearchController.h"
#import "WebController.h"
#import "DetailController.h"

// ViewModel
#import "RFDataManager.h"
#import "RFParser.h"
//
#import <Masonry.h>
// View
#import "HotMovieView.h"
#import "TopView.h"

#import "ReFilm-Swift.h"

#define MAIN_HEIGHT    (self.view.frame.size.height)
#define MAIN_WIDTH    (self.view.frame.size.width)


@interface MasterViewController()<UIScrollViewDelegate,UISearchBarDelegate,RFDataManagerDelegate,HotMovieViewDelegate,TopViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITapGestureRecognizer *searchTapGesture;
@property (nonatomic, strong) HotMovieView *hotMovieView;
@property (nonatomic, strong) HotMovieView *comingMovieView;
@property (nonatomic, strong) TopView *topView;
@property (nonatomic, strong) NSArray *hotMovies;
@property (nonatomic, strong) NSArray *comingMovies;
@property (nonatomic, strong) NSArray *topMovies;

@end


@implementation MasterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //: Main ScrollView
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT-113)];
    [self.view addSubview:_scrollView];
    

    _scrollView.contentSize = CGSizeMake(MAIN_WIDTH * 3, MAIN_HEIGHT-113);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = YES;
    _scrollView.delegate = self;
    _scrollView.directionalLockEnabled = YES;


    //: UISegmentedControl
    
    _segmentControl = [[UISegmentedControl alloc]init];
    _segmentControl.center = CGPointMake(MAIN_WIDTH/2.0, 22);
    [_segmentControl setBounds:CGRectMake(0, 0, 210, 30)];
    [_segmentControl setTintColor:[UIColor whiteColor]];
    [_segmentControl insertSegmentWithTitle:@"正在热映" atIndex:0 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"即将上映" atIndex:1 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"TOP100" atIndex:2 animated:YES];
    [_segmentControl addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
    [_segmentControl setSelectedSegmentIndex:0];
    self.navigationItem.titleView = _segmentControl;
    //[self.navigationController.navigationBar addSubview:_segmentControl];
    //[self test];
    
    UIBarButtonItem *search = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showSearchController:)];
    self.navigationItem.rightBarButtonItem = search;
    
    RFProgressHUD *hud = [[RFProgressHUD alloc]initWithFrame:CGRectMake(MAIN_WIDTH/2.0 - 75, MAIN_HEIGHT/2.0 -75, 150, 150) radius:40 duration:2];
    [self.view addSubview:hud];
    [hud startAnimating];
    
    
    self.hotMovieView = [[HotMovieView alloc]initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT-113)];
    self.hotMovieView.delegate = self;
    self.hotMovieView.tag = 10011;
    [_scrollView addSubview:self.hotMovieView];
    [self loadHotView];
    
    self.comingMovieView = [[HotMovieView alloc]initWithFrame:CGRectMake(MAIN_WIDTH, 0, MAIN_WIDTH, MAIN_HEIGHT-113)];
    self.comingMovieView.delegate = self;
    self.comingMovieView.tag = 10001;
    //self.comingMovieView.backgroundColor = [UIColor greenColor];
    [_scrollView addSubview:self.comingMovieView];
    [self loadComingView];
    
    self.topView = [[TopView alloc]initWithFrame:CGRectMake(MAIN_WIDTH * 2, 0, MAIN_WIDTH, MAIN_HEIGHT-113)];
    [_scrollView addSubview:self.topView];
    self.topView.delegate = self;
    [self loadTopView];

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
}

- (void)loadHotView {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        RFDataManager *manager = [RFDataManager sharedManager];
        [manager sendRequestForHotMovies];
        manager.delegate = self;
    });
    
}

- (void)loadComingView {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        RFDataManager *manager = [RFDataManager sharedManager];
        [manager sendRequestForCommingMovies];
        manager.delegate = self;
    });
}

- (void)loadTopView {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        RFDataManager *manager = [RFDataManager sharedManager];
        [manager sendRequestForTop100Movies];
        manager.delegate = self;
    });
}

#pragma mark - UISegmentedControl-Action
- (void)segmentedControlChanged:(UISegmentedControl *)segmentedControl {
    NSInteger index = segmentedControl.selectedSegmentIndex;
    switch (index) {
        case 0:[self scrollView:_scrollView scrollWithOffSetX:0]; break;
        case 1:[self scrollView:_scrollView scrollWithOffSetX:MAIN_WIDTH]; break;
        case 2:[self scrollView:_scrollView scrollWithOffSetX:MAIN_WIDTH * 2]; break;
            
        default:
            break;
    }
    
}

- (void)scrollView:(UIScrollView *)scrollView scrollWithOffSetX:(CGFloat)offset {
    [UIView animateWithDuration:0.5 animations:^{
        [scrollView setContentOffset:CGPointMake(offset, 0)];
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
    NSInteger index = x / MAIN_WIDTH;
    [_segmentControl setSelectedSegmentIndex:index];
    
}


#pragma mark - Test

- (void)test {
    
    RFDataManager *manager = [RFDataManager sharedManager];
    [manager sendRequestForCommingMovies];
    manager.delegate = self;
   // [manager sendRequestForCommentWithMovieID:@"25794302"];
   // [manager sendRequestSearchMovieWithName:@"美国队长"];
}

- (void)showSearchController:(id)sender {
    self.hidesBottomBarWhenPushed = YES;

    SearchController *search = [SearchController new];
    [self showViewController:search  sender:nil];
    self.hidesBottomBarWhenPushed = NO;

  //  [_segmentControl removeFromSuperview];
}


#pragma mark - HotMovieViewDelegate

- (void)touchCollectionView:(UICollectionView *)tableView CellAtIndex:(NSInteger)index inView:(UIView *)view{
    NSLog(@"touch %lu",index);
    if (view.tag == 10011) {
        self.hidesBottomBarWhenPushed = YES;
        
        DetailController *detailController = [DetailController new];
        detailController.movie = [self.hotMovies objectAtIndex:index];
        
        [self showViewController:detailController sender:nil];
        self.hidesBottomBarWhenPushed = NO;
    }
    else if (view.tag == 10001) {
        self.hidesBottomBarWhenPushed = YES;
        WebController *webController = [WebController new];
        Movie *movie = [self.comingMovies objectAtIndex:index];
        NSLog(@"%@",movie.alt);
        NSString *url = movie.alt;//[RFParser getURLFromFavoriteMovies:[self.hotMovies objectAtIndex:index]];
        webController.openURL = url;
        webController.movie = movie;
        [self showViewController:webController sender:nil];
        self.hidesBottomBarWhenPushed = NO;

    }
    
    
    /// 打开WebController
#if 0
    WebController *webController = [WebController new];
    Movie *movie = [self.hotMovies objectAtIndex:index];
    NSLog(@"%@",movie.alt);
    NSString *url = movie.alt;//[RFParser getURLFromFavoriteMovies:[self.hotMovies objectAtIndex:index]];
    webController.openURL = url;
    webController.movie = movie;
    [self showViewController:webController sender:nil];
#endif
    /// 打开DetailController
#if 1

#endif
    
}

- (void)longTouchCellAtIndex:(NSInteger)index {
    NSLog(@"long touch %lu",index);
}


#pragma mark - RFDataManagerDelegate
- (void)didReceiveHotMovieDataWith:(NSArray *)movies error:(NSString *)error {
    if (error) {
        NSLog(@"errorz: %@",error);
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.hotMovies = movies;
            [_hotMovieView loadDataWithArray:movies];
        });
    }
}

- (void)didReceiveCommingMovies:(NSArray *)movies error:(NSString *)error {
    if (error) {
        NSLog(@"errorz: %@",error);
        
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.comingMovies = movies;
            [_comingMovieView loadDataWithArray:movies];
        });
    }
}

- (void)didReceiveTopMovies:(NSArray *)movies error:(NSString *)error {
    if (error) {
        NSLog(@"errorz: %@",error);
        
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.topMovies = movies;
            [_topView loadWithArray:movies];
        });
    }
}


#pragma mark - TopViewDelegate

- (void)didSelectedRowAtIndex:(NSInteger)index {
    self.hidesBottomBarWhenPushed = YES;
    DetailController *detailController = [DetailController new];
    detailController.movie = [self.topMovies objectAtIndex:index];
    [self showViewController:detailController sender:nil];
    self.hidesBottomBarWhenPushed = NO;
}

@end
