//
//  HotMovieView.m
//  ReFilm
//
//  Created by VicChan on 5/13/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "HotMovieView.h"
#import "MovieCollectionCell.h"
#import "RFParser.h"
#import "RFViewModel.h"
#import "ReFilm-Swift.h"


#define MAIN_WIDTH   (self.frame.size.width)
#define MAIN_HEIGHT  (self.frame.size.height)



@interface HotMovieView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>
{
    CGSize itemSize;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, strong) UIRefreshControl *refreshControl;


@end


static NSString *cellIdentifier = @"hotMovieCollectionCell";
static NSString *cellCommingIdentifier = @"commingMovieCollectionCell";

@implementation HotMovieView

- (id)initWithFrame:(CGRect)frame type:(MovieViewType)type {
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
        CGFloat itemWidth = (MAIN_WIDTH-30)/2;
        itemSize = CGSizeMake(itemWidth, itemWidth * 60/42);
        self.movies = [NSArray new];
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
        [self addSubview:self.collectionView];
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.dataSource = self;

        self.refreshControl = [[UIRefreshControl alloc]init];
        [self.refreshControl addTarget:self action:@selector(refreshMovies:) forControlEvents:UIControlEventValueChanged];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新" attributes:nil];
        self.refreshControl.tintColor = [UIColor greenColor];
        [self.collectionView addSubview:self.refreshControl];
        self.collectionView.alwaysBounceVertical = YES;
        
        
        _movieViewType = type;
        if (type == MovieViewTypeHotMovie) {
            [self.collectionView registerClass:[MovieCollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
        } else if (type == MovieViewTypeComingMovie) {
            [self.collectionView registerClass:[ComingMovieViewCell class] forCellWithReuseIdentifier:cellCommingIdentifier];
        }
        
        
        UILabel *sourceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, 20)];
        sourceLabel.text = @"电影信息来源于[豆瓣电影]";
        sourceLabel.textAlignment = NSTextAlignmentCenter;
        sourceLabel.font = [UIFont systemFontOfSize:13];
        sourceLabel.textColor = [UIColor lightGrayColor];
        //self.collectionVie
#if 0
        _longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressed:)];
        _collectionView.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
        _longPressGesture.numberOfTapsRequired = 1;
        _longPressGesture.numberOfTouchesRequired = 1;
        _longPressGesture.minimumPressDuration = 0.5;
        _longPressGesture.delegate = self;
        _longPressGesture.delaysTouchesBegan = NO;
        [_collectionView addGestureRecognizer:_longPressGesture];
#endif

        
    }
    return self;
}

- (void)refreshMovies:(UIRefreshControl *)refreshControl {
    NSLog(@"refresh");
    
    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"正在刷新" attributes:nil];
    [_delegate refreshMoviesWithView:self];
    
    
    /*
    [NSThread sleepForTimeInterval:5];
    if (refreshControl.refreshing == YES) {
        [refreshControl endRefreshing];
    }
    
    */
    
}


#pragma mark - UICollectionViewDelegate || UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row + indexPath.section * 2;


    if (_movieViewType == MovieViewTypeHotMovie) {
        MovieCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        RFViewModel *rfViewModel = [[RFViewModel alloc]init];
        Movie *movie = [self.movies objectAtIndex:index];
        if (movie == nil) {
            return nil;
        }
        [rfViewModel handleCollectionCell:cell withMovie:movie];
        return cell;
        
    } else if (_movieViewType == MovieViewTypeComingMovie) {
        ComingMovieViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellCommingIdentifier forIndexPath:indexPath];
        RFViewModel *rfViewModel = [[RFViewModel alloc]init];
        Movie *movie = [self.movies objectAtIndex:index];
        if (movie == nil) {
            return nil;
        }
        [rfViewModel handleComingCell:cell withMovie:movie];
        return cell;

    }
    return nil;
}




- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.movies.count == 0) {
        return 0;
    } else if (self.movies.count %2 == 0) {
        return self.movies.count /2 ;
    }
    else if (self.movies.count %2 != 0 ) {
        return self.movies.count/2 + 1;
    }
    return 0;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section <= self.movies.count/2-1) {
        return 2;
    }
    else if (section == self.movies.count/2) {
        return 1;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return itemSize;
}

// 垂直间距：
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.section * 2 + indexPath.row;
    [_delegate touchCollectionView:collectionView CellAtIndex:index inView:self];
}



/*
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
*/



- (void)loadDataWithArray:(NSArray *)array {
    self.movies = array;
    [self.collectionView reloadData];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新完成" attributes:nil];
    [self.refreshControl endRefreshing];
}

/*
- (void)longPressedCellWith:(MovieCollectionCell *)cell {
    NSLog(@"adfsghc");
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    NSInteger index = indexPath.section * 2 + indexPath.row;
    [_delegate longTouchCellAtIndex:index];
}
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@",touches);
    
}
#if 0
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"sadfgdhfgm");
}
#endif
#pragma mark - UIGesture

- (void)longPressed:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"long begin");
        CGPoint point = [recognizer locationInView:self];
        NSLog(@"%@",NSStringFromCGPoint(point));
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"ended");
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}


- (void)finishRefreshWithArray:(NSArray *)array {
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新完成" attributes:nil];
    [self.refreshControl endRefreshing];
    self.movies = array;
    [self.collectionView reloadData];
}


@end
