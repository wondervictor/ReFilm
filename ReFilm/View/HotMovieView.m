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


#define MAIN_WIDTH   (self.frame.size.width)
#define MAIN_HEIGHT  (self.frame.size.height)


@interface HotMovieView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    CGSize itemSize;
}
@property (nonatomic, strong) UICollectionView *collectionView;


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
        

        
    }
    return self;
}


#pragma mark - UICollectionViewDelegate || UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row + indexPath.section * 2;

    NSLog(@"index: %lu",index);

    MovieCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    [RFParser handleCell:cell withMovie:[self.movies objectAtIndex:index]];
    NSLog(@"index: %lu",index);
    
    return cell;
}




- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"%lu",self.movies.count);
    return self.movies.count/2 + 1;
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

/*
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
*/



- (void)loadDataWithArray:(NSArray *)array {
    self.movies = array;
    NSLog(@"asdsfg");
    
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





@end
