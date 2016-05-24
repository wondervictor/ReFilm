//
//  TopView.h
//  ReFilm
//
//  Created by VicChan on 5/22/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopViewDelegate <NSObject>

- (void)didSelectedRowAtIndex:(NSInteger)index;

@end

@interface TopView : UIView

@property (nonatomic, strong) NSArray *topMovies;

@property (nonatomic, weak) id <TopViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;

- (void)loadWithArray:(NSArray *)movies;

@end
