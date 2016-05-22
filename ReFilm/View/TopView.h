//
//  TopView.h
//  ReFilm
//
//  Created by VicChan on 5/22/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopView : UIView

@property (nonatomic, strong) NSArray *topMovies;

- (id)initWithFrame:(CGRect)frame;

- (void)loadWithArray:(NSArray *)movies;

@end
