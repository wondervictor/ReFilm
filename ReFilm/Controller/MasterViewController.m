//
//  MasterViewController.m
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//
// Controller
#import "MasterViewController.h"
// ViewModel
#import "RFDataManager.h"
//
#import <Masonry.h>

#define MAIN_HEIGHT    ([UIScreen mainScreen].bounds.size.height)
#define MAIN_WIDTH    (self.view.frame.size.width)


@interface MasterViewController()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UISegmentedControl *segmentControl;


@end


@implementation MasterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //: Main ScrollView
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MAIN_WIDTH, MAIN_HEIGHT-113)];
    [self.view addSubview:_scrollView];

    _scrollView.contentSize = CGSizeMake(MAIN_WIDTH * 3, MAIN_HEIGHT-113);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = YES;
    _scrollView.delegate = self;
    _scrollView.directionalLockEnabled = YES;

    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:redView];
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scrollView.mas_centerX).with.offset(MAIN_WIDTH);
        make.centerY.equalTo(_scrollView.mas_centerY);
        make.height.equalTo(_scrollView.mas_height);
        make.width.equalTo(_scrollView.mas_width);
    }];
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
    [self.navigationController.navigationBar addSubview:_segmentControl];
   // [self test];
    
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
}



@end
