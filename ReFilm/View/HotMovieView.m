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


#define MAIN_WIDTH   (self.frame.size.width)
#define MAIN_HEIGHT  (self.frame.size.height)


@interface HotMovieView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>
{
    CGSize itemSize;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;

@end

static NSString *cellIdentifier = @"hotMovieCollectionCell";

@implementation HotMovieView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
        CGFloat itemWidth = (MAIN_WIDTH-30)/2;
        itemSize = CGSizeMake(itemWidth, itemWidth * 60/42);
        self.movies = [NSArray new];
        self.collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
        [self addSubview:self.collectionView];
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.dataSource = self;

        [self.collectionView registerClass:[MovieCollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
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


#pragma mark - UICollectionViewDelegate || UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row + indexPath.section * 2;

    NSLog(@"index: %lu",index);

    MovieCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    RFViewModel *rfViewModel = [[RFViewModel alloc]init];
    Movie *movie = [self.movies objectAtIndex:index];
    if (movie == nil) {
        return nil;
    }
    [rfViewModel handleCollectionCell:cell withMovie:movie];
    
    
    return cell;
}




- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"%lu",self.movies.count);
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
    [_delegate touchCellAtIndex:index];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

/*
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
*/



- (void)loadDataWithArray:(NSArray *)array {
    self.movies = array;    
    [self.collectionView reloadData];
}
/*
- (void)longPressedCellWith:(MovieCollectionCell *)cell {
    NSLog(@"adfsghc");
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    NSInteger index = indexPath.section * 2 + indexPath.row;
    [_delegate longTouchCellAtIndex:index];
}
 */
/*
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@",touches);
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"sadfgdhfgm");
}
*/
#pragma mark - UIGesture

- (void)longPressed:(UILongPressGestureRecognizer *)recognizer {
    NSLog(@"adfsghd");
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


@end
